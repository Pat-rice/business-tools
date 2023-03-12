# Business tools stack

Are you sick of all these subscriptions that costs between 4-10$/month/user ?

This repo contains docker compose files to start various tools commonly needed by business.

These tools are most suited for startup and small businesses as it's intended to run on a single server.

You should also be comfortable with a little involvment in maintenance and perhaps service disruption.

That being said it's actually very helpful and can save you a lot of money while you get your business started and/or growing.
If you grow too large for a single server setup, you should have enough money (hope so !) 
to either pay for a hosted version or you have an ops team that can deploy these tools in a high availibility infrastructure.

If you want to add a service, don't hesitate to create a pull request.

## Prerequisites

- You should have a running server reachable from outside, ideally with a static IP address.
- You should have `docker` (version 23 or greater) and `docker compose` (version 2.16 or greater) setup
- The port `80` and `443` open
- A wildcard DNS A record that points to this server IP: `*.example.com A 1.2.3.4`

## Getting started

The only mandatory service is the reverse proxy (traefik) located at the root of the project.
So first follow the instruction while being a the root of the project. Then go to any service directory and do the same steps.

To start a service do the following:
1. Copy the .env.example and name it .env
1. Update the .env file with your values (Domain name, credentials, etc..)
1. `docker compose up -d`

You can test the reverse proxy setup with the simple service `whoami` and you can also activate its dashboard (don't forget to update the credentials)

## Services

List of services currently present:
- Traefik (reverse proxy, mandatory)
- Whoami
- Keycloak