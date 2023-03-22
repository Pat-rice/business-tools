# Mattermost

## Backup

In order to help you do backups, there is a script available.
The script create an encrypted archive and upload it to an S3 bucket.
You'll need `gpg` setup on your host (should be available by default on most linux distribution).

To check if you have gpg run: `gpg --version`

To run the backup script manually do the following:

1. Make it executable (once): `chmod a+x scripts/backup.sh`
1. Run the script: `./scripts/backup.sh`

You could also configure a cronjob to execute it regularly.

## Restore

The restore script should work if you have made the backup with the backup script.

If you're starting from a fresh install, you have to do a `docker compose up -d` first in order to create volumes and have a running db.

Find the name of the backup file you want to restore, and run the following:

1. Make it executable (once): `chmod a+x scripts/restore.sh`
1. Run the script: `./scripts/restore.sh mybackupname.tar.gz.gpg`

