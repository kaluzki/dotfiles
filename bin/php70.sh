#!/usr/bin/env sh

docker run -i --rm -v "${PWD}":"${PWD}" -v /tmp/:/tmp/ -w "${PWD}" php:7.0-alpine php "$@"
