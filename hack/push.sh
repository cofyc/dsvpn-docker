#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

ROOT=$(unset CDPATH && cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)
cd $ROOT

if [ -n "${DOCKER_USERNAME:-}" -a -n "${DOCKER_PASSWORD:-}" ]; then
    echo "info: DOCKER_USERNAME & DOCKER_PASSWORD are both set"
    docker login --username $DOCKER_USERNAME --password-stdin <<<"$DOCKER_PASSWORD"
fi

for tag in $(cat .IMAGE_TAGS); do
    image=cofyc/dsvpn:$tag
    echo "info: pushing $image"
    docker push $image
done
