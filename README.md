# Business tools stack

This repo contains docker compose files to start various tools commonly needed by businesses.

These tools are most suited for startup and small businesses as it's intended to run on a single server.

You should also be comfortable with a little involvment in maintenance and perhaps service disruption.

That being said it's actually very helpful and can save you a lot of money while you get your business started and/or growing.
If you grow too large for a single server setup, you should have enough money (hope so !) 
to either pay for a hosted version or you have an ops team that can deploy these tools in a highly available infrastructure.

If you want to add a service, don't hesitate to create a pull request.

## Warning

This repo aims to facilitate the deployment of tools behind a reverse proxy with automated SSL management.
However, it doesn't cover server security for which YOU are responsible.

It's already well described in [Geerling Guy's ansible playbook](https://github.com/geerlingguy/ansible-role-security) and you can use it to start securing your server.
For a thorough guide, see https://github.com/imthenachoman/How-To-Secure-A-Linux-Server

Although the data are persisted to the host machine, you are responsible for backups.

## Prerequisites

- A running server reachable from outside
- You should have [`docker`](https://www.docker.com/) (version 23 or greater) and [`docker compose`](https://docs.docker.com/compose/) (version 2.16 or greater) setup
- The port `80` and `443` open
- A wildcard DNS A record (or a DNS A record per service) that points to this server IP: `*.example.com A 1.2.3.4`

## Getting started

The only mandatory service is the reverse proxy (traefik) located at the root of the project.
So first follow the instruction while being at the root of the project. Then go to any service directory and do the same steps.

To start a service do the following:
1. Copy the .env.example and name it .env
1. Update the .env file with your values (Domain name, credentials, etc..)
1. `docker compose up -d`

You can test the reverse proxy setup with the simple service `whoami` and you can also activate its dashboard (don't forget to update the credentials)

Please note that service containers have to be in "healthy" state before being accessible

## Services

List of services currently present:
- [Traefik](https://doc.traefik.io/traefik/) - **mandatory** - reverse proxy
- [Whoami](https://hub.docker.com/r/containous/whoami) - test service
- [Keycloak](https://www.keycloak.org/) - IAM
- [Mattermost](https://mattermost.com/) - Team chat
- [Wordpress](https://wordpress.org/) - CMS
- [Vikunja](https://vikunja.io/) - Todo app

Wish list:
- Jitsi
- Discourse
- Nextcloud
- Gitea
- Gitlab
- Cal.com
- Zulip
- Grafana
- Loki
- Prometheus
- Supabase
- Plausible
- Matomo
- Outline
- Odoo
- Uptime-Kuma