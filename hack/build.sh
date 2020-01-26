#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

ROOT=$(unset CDPATH && cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)
cd $ROOT

GIT_REPO=https://github.com/jedisct1/dsvpn.git

tmpdir=$(mktemp -d)
trap "rm -rf $tmpdir" EXIT

echo "Checking out $GIT_REPO into $tmpdir"
cd $tmpdir
git init
git fetch --tags --progress $GIT_REPO +refs/heads/*:refs/remotes/origin/*
refs="master $(git tag -l)"

cd $ROOT

echo "info: building images for following git refs"
for ref in $refs; do
    echo "    $ref"
done

echo > .IMAGE_TAGS
for ref in $refs; do
    tag=$ref
    if [ "$ref" == "master" ]; then
        tag=latest
    fi
    image=cofyc/dsvpn:$tag
    echo "info: build $ref as image $image"
    docker build --no-cache -t $image --build-arg GIT_REF=$ref .
    echo $tag >> .IMAGE_TAGS
done
