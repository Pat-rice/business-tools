# Gitlab

## Post install steps

After running `docker compose up -d` you can retrieve the initial admin credentials with the following command:

`docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password`

---

## Backup

The following commands are provided to help you define a backup strategy, **you** are responsible to test and manage these backups

**Create a manual backup** (If you have setup S3 credentials correctly, the backup should be present on your bucket.):

```
docker exec -t gitlab gitlab-backup create
```


You should also backup the sensitive files with secrets and credentials
https://docs.gitlab.com/ee/raketasks/backup_gitlab.html#storing-configuration-files

You can create a tar from the docker volume `gitlab_config` as the configuration files and secrets are stored in this volume

```
docker run --rm \
-v gitlab_config:/etc/gitlab \
-v `pwd`:/backup \
busybox \
tar czf /backup/gitlab-config-backup.tar.gz /etc/gitlab
```

Backup this file somewhere safe