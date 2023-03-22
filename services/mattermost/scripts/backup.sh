#!/bin/bash
# Loading .env file
ENV_VARS="$(cat .env | awk '!/^\s*#/' | awk '!/^\s*$/')"

eval "$(
  printf '%s\n' "$ENV_VARS" | while IFS='' read -r line; do
    key=$(printf '%s\n' "$line"| sed 's/"/\\"/g' | cut -d '=' -f 1)
    value=$(printf '%s\n' "$line" | cut -d '=' -f 2- | sed 's/"/\\\"/g')
    printf '%s\n' "export $key=\"$value\""
  done
)"

# Dump DB
docker compose exec -T db pg_dump -Fc "$DB_NAME" -U "$DB_USER" > mattermost-postgres.dump
# Package mattermost data
docker run --rm \
      -v mattermost_mattermost:/backup-volume \
      -v "$(pwd)":/tmp \
      -w /tmp \
      busybox \
      tar -cpf mattermost.tar -C /backup-volume .
# Compress both, db and data
date=$(date '+%Y-%m-%d')
docker run --rm \
      -v "$(pwd)":/tmp \
      -w /tmp \
      busybox \
      tar -czf "backup-mattermost-$date.tar.gz" mattermost.tar mattermost-postgres.dump
# Encrypt backup
gpg --output "backup-mattermost-$date.tar.gz.gpg" --symmetric --batch --yes --passphrase "$ENCRYPTION_PASSPHRASE" "backup-mattermost-$date.tar.gz"
# Upload backup (use docker)
docker run --rm \
      -v "$(pwd)":/tmp \
      -w /tmp \
      -e AWS_ACCESS_KEY_ID="$S3_ACCESS_KEY" \
      -e AWS_SECRET_ACCESS_KEY="$S3_SECRET_KEY" \
      -e AWS_REGION="$S3_REGION" \
      amazon/aws-cli \
      --endpoint-url "$S3_ENDPOINT" \
      s3 cp "backup-mattermost-$date.tar.gz.gpg" s3://"$S3_BUCKET"
## Cleanup
rm -rf "backup-mattermost-$date.tar.gz.gpg" "backup-mattermost-$date.tar.gz" mattermost.tar mattermost-postgres.dump