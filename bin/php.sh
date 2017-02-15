#!/usr/bin/env sh

docker run -i --rm -v "${PWD}":"${PWD}" -v /tmp/:/tmp/ -w "${PWD}" php:alpine php "$@"
