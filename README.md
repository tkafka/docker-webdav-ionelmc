# NGINX WebDAV https container

Usage:

```bash
docker run --restart always --detach --name webdav --publish 443:443 \
           --env UID=$UID --volume $PWD:/media ionelmc/webdav
```

## Configure

### Mandatory

Map `/media` to your media folder

Map `/etc/nginx/cert.crt` and `/etc/nginx/cert.key` to your own https certificate.

### Optional

Optionally you can add two environment variables to require HTTP basic authentication:

* WEBDAV_USERNAME
* WEBDAV_PASSWORD

Example:

```bash
docker run --restart always --detach --name webdav --publish 7000:8080 \
           --env WEBDAV_USERNAME=myuser --env WEBDAV_PASSWORD=mypassword \
           --env UID=$UID --volume $PWD:/media ionelmc/webdav
```

And you can set up maximum allowed upload size with `CLIENT_MAX_BODY_SIZE` env. variable, like this:

```bash
docker run --restart always --detach --name webdav --publish 7000:8080 \
           --env CLIENT_MAX_BODY_SIZE=50G \
           --env UID=$UID --volume $PWD:/media ionelmc/webdav
```

## Build and push on m1 - this is the way

See [howto](https://blog.jaimyn.dev/how-to-build-multi-architecture-docker-images-on-an-m1-mac/)

Init once:
`docker buildx create --use`

Buil and push:
`docker buildx build --platform linux/amd64,linux/arm64 --push -t tomaskafka/docker-webdav-ionelmc-tkafka:latest -t tomaskafka/docker-webdav-ionelmc-tkafka:bionic .`

## Build it old way for single platform
See [docker help](https://docs.docker.com/docker-hub/)

Use any tag you like:

`docker build -t docker-webdav-ionelmc-tkafka:bionic -t docker-webdav-ionelmc-tkafka:latest .`


### Run it locally

Name a container `webdav`

`docker run --name webdav --volume $PWD:/media -e WEBDAV_USERNAME=www -e WEBDAV_PASSWORD=password -e CLIENT_MAX_BODY_SIZE=1G docker-webdav-ionelmc-tkafka:latest`

### Poke it

Use container name `webdav`

`docker exec -it webdav /bin/bash`

### Tag it

`docker tag tomaskafka/docker-webdav-ionelmc-tkafka tomaskafka/docker-webdav-ionelmc-tkafka:bionic`
`docker tag tomaskafka/docker-webdav-ionelmc-tkafka tomaskafka/docker-webdav-ionelmc-tkafka:latest`


### Push it

`docker push tomaskafka/docker-webdav-ionelmc-tkafka:bionic`
`docker push tomaskafka/docker-webdav-ionelmc-tkafka:latest`

### Delete it

`docker rm docker-webdav-ionelmc-tkafka:latest`

## Optimize build

See https://contains.dev/tomaskafka/docker-webdav-ionelmc-tkafka
