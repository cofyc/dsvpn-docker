#!/bin/bash

source config.sh

if [ -n "$DOCKER_USERNAME" -a -n "$DOCKER_PASSWORD" ]; then
    echo "info: DOCKER_USERNAME & DOCKER_PASSWORD are both set"
    docker login --username $DOCKER_USERNAME --password-stdin <<<"$DOCKER_PASSWORD"
fi

for ref in ${!config[*]}; do
    tag=${config[$ref]}
    image=cofyc/dsvpn:$tag
    echo "info: pushing $image"
    docker push $image
done
