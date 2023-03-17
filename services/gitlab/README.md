# Gitlab

## Post install steps

After running `docker compose up -d` you can retrieve the initial admin credentials with the following command:

`docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password`