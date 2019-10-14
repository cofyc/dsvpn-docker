#!/bin/bash

source config.sh

for ref in ${!config[*]}; do
    tag=${config[$ref]}
    image=cofyc/dsvpn:$tag
    echo "info: build $ref as image $image"
    docker build --no-cache -t $image --build-arg GIT_REF=$ref .
done
