# NGINX WebDAV container

Usage:

```bash
docker run --restart always --detach --name webdav --publish 7000:8080 \
           --env UID=$UID --volume $PWD:/media ionelmc/webdav
```

## Configure

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

## Build it
See [docker help](https://docs.docker.com/docker-hub/)

Use any tag you like:

`docker build -t docker-webdav-ionelmc-tkafka:nginx-alpine .`

## Test it

`docker run docker-webdav-ionelmc-tkafka:nginx-alpine`

## Push it

`docker push tomaskafka/docker-webdav-ionelmc-tkafka`