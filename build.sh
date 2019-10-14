#!/bin/bash

declare -A config
config["master"]="latest"
config["0.1.3"]="0.1.3"

for ref in ${!config[*]}; do
    tag=${config[$ref]}
    image=cofyc/dsvpn:$tag
    echo "info: build $ref as image $image"
    docker build --no-cache -t $image --build-arg GIT_REF=$ref .
    docker push $image
done
