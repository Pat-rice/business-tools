# Docker registry

It persists images on host disk.
You can modify it to enable [different storage](https://docs.docker.com/registry/configuration/#storage)

## Warning

You have to update the htpasswd file with a new set of credentials:
`htpasswd -Bbn <user> <password>`

## Usage

Login to the registry: `docker login -u user -p "password" $DOMAIN`

Tag an image: `docker tag containous/whoami $DOMAIN/containous/whoami`

Push an image: `docker push $DOMAIN/containous/whoami`

Pull an image: `docker pull $DOMAIN/containous/whoami`