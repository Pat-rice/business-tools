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

# Download backup
docker run --rm \
      -v "$(pwd)":/tmp \
      -w /tmp \
      -e AWS_ACCESS_KEY_ID="$S3_ACCESS_KEY" \
      -e AWS_SECRET_ACCESS_KEY="$S3_SECRET_KEY" \
      -e AWS_REGION="$S3_REGION" \
      amazon/aws-cli \
      --endpoint-url "$S3_ENDPOINT" \
      s3 cp s3://"$S3_BUCKET/$1" .

# Decrypt backup
echo "$ENCRYPTION_PASSPHRASE" | gpg --output backup-mattermost.tar.gz --batch --yes --passphrase-fd 0 -d "$1"

# Unpack backup
docker run --rm \
      -v "$(pwd)":/tmp \
      -w /tmp \
      busybox \
      tar -xzf backup-mattermost.tar.gz

# Restore mattermost data
docker run --rm \
      -v mattermost_mattermost:/backup-volume \
      -v "$(pwd)":/tmp \
      -w /tmp \
      busybox \
      tar -xf mattermost.tar -C /backup-volume

# Restore db
docker cp mattermost-postgres.dump mattermost-db:/var/lib/postgresql/
docker exec mattermost-db pg_restore --clean -U "$DB_USER" -d "$DB_NAME" /var/lib/postgresql/mattermost-postgres.dump

# Cleanup
rm -rf "$1" backup-mattermost.tar.gz mattermost.tar mattermost-postgres.dump