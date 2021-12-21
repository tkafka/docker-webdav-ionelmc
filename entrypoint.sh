#!/bin/sh -eux

if [ -n "${WEBDAV_USERNAME:-}" ] && [ -n "${WEBDAV_PASSWORD:-}" ]; then
    echo "Configured htpasswd for ${WEBDAV_USERNAME}"
    htpasswd -cb /etc/nginx/webdavpasswd $WEBDAV_USERNAME $WEBDAV_PASSWORD
else
    echo "No htpasswd config done"
    sed -i 's%auth_basic "Restricted";% %g' /etc/nginx/nginx.conf
    sed -i 's%auth_basic_user_file webdavpasswd;% %g' /etc/nginx/nginx.conf
fi

if [ -n "${HTTP_PORT:-}" ]; then
    echo "Setting http port to ${HTTP_PORT}"
else
    HTTP_PORT=80
    echo "Keeping default http port ${HTTP_PORT}"
fi
sed -i "s%HTTP_PORT%${HTTP_PORT}%g" /etc/nginx/nginx.conf

if [ -n "${HTTPS_PORT:-}" ]; then
    echo "Setting https port to ${HTTPS_PORT}"
else
    HTTP_PORT=443
    echo "Keeping default https port ${HTTP_PORT}"
fi
sed -i "s%HTTPS_PORT%${HTTPS_PORT}%g" /etc/nginx/nginx.conf

if [ -n "${CLIENT_MAX_BODY_SIZE:-}" ]; then
    echo "Setting client_max_body_size to ${CLIENT_MAX_BODY_SIZE}"
else
    CLIENT_MAX_BODY_SIZE=500M
    echo "Keeping default client_max_body_size ${CLIENT_MAX_BODY_SIZE}"
fi
sed -i "s%CLIENT_MAX_BODY_SIZE%${CLIENT_MAX_BODY_SIZE}%g" /etc/nginx/nginx.conf

if [ -n "${UID:-}" ]; then
    chmod go+w /dev/stderr /dev/stdout
    gosu $UID mkdir -p /media/.tmp
    exec gosu $UID "$@"
else
    mkdir -p /media/.tmp
    exec "$@"
fi
