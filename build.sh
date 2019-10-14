#!/bin/bash

declare -A config
config["master"]="latest"
config["0.1.3"]="0.1.3"

if [ -n "$PUSH" ]; then
  if [ -n "$DOCKER_USERNAME" -a -n "$DOCKER_PASSWORD" ]; then
    echo "info: DOCKER_USERNAME & DOCKER_PASSWORD are both set"
    docker login --username $DOCKER_USERNAME --password-stdin <<<"$DOCKER_PASSWORD"
  fi
fi

for ref in ${!config[*]}; do
  tag=${config[$ref]}
  image=cofyc/dsvpn:$tag
  echo "info: build $ref as image $image"
  docker build --no-cache -t $image --build-arg GIT_REF=$ref .
  if [ -n "$PUSH" ]; then
    docker push $image
  fi
done
