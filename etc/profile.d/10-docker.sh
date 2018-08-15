#!/usr/bin/env bash

alias d-install='curl -sSL https://get.docker.com/ | sh && sudo usermod -aG docker $USER'

# docker
if [ -x /usr/bin/docker ]; then
    ##
    # @param bool interactive
    # @param mixed... cmd
    # @param string image
    ##
    _docker_run() {
        local interactive image cmd
        [ $1 = 'true' ] && interactive='--interactive --tty' || interactive='--detach'
        image="${@: -1}" # the last argument
        cmd=${@:2:$(($#-2))} # all arguments except the first and last one
        docker run --publish-all $interactive $image $cmd
    }

    alias d-images='docker images'

    alias d-ps='docker ps'
    alias d-id='docker ps --quiet --latest'
    alias d-id-running='docker ps --quiet --latest --filter status=running'
    alias d-ids='docker ps --quiet --all'
    alias d-ids-running='docker ps --quiet --all --filter status=running'

    alias d-run='docker run'
    alias d-run-daemon='docker run --detach'
    alias d-run-interactive='docker run --interactive --tty'
    alias d-sh='_docker_run true /bin/sh'
    alias d-bash='_docker_run true /bin/bash'

    alias d-stop='docker stop'
    alias d-rm='docker rm'

    alias d-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

    ##
    # get docker host ip
    ##
    d-host-ip() {
        ip -4 addr show scope global dev docker0 | grep inet | awk '{print $2}' | cut -d / -f 1
    }

    ##
    # phpfn/php:*
    ##
    d-php() {
        local name=${PWD##*/} version='72' cmd='php' composerHome=${COMPOSER_HOME:-$HOME/.composer} tty

        mkdir -p ${composerHome}

        [[ $1 == :* ]] && {
            version=$(echo $1| cut -d':' -f 2)
            shift
        }
        [[ $1 == 'bash' ]] && {
            cmd=$1
            shift
        }

        tty -s && tty=--tty

        docker run \
            $tty \
            --interactive \
            --rm \
            --hostname "$name" \
            --name "$name" \
            --expose '8080' \
            --network 'traefik' \
            --label 'traefik.docker.network=traefik' \
            --label 'traefik.enable=true' \
            --label "traefik.frontend.rule=Host:$name.localhost" \
            --label 'traefik.backends.php.url=*:8080' \
            --volume $(pwd):/app \
            --volume "$composerHome":/home/application/.composer \
            --env XDEBUG_REMOTE_HOST=$(d-host-ip) \
            phpfn/"$version" "$cmd" "$@"
    }

    ##
    # list tables of the current docker-compose app
    ##
    dc-db() {
        local CMD='exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"'
        docker-compose exec -u $UID db sh -c "$CMD 2>/dev/null"
    }

    ##
    # list tables of the current docker-compose app
    ##
    dc-tables() {
        local CMD='exec mysql -NBA -uroot -p"$MYSQL_ROOT_PASSWORD" -D "$MYSQL_DATABASE" -e "SHOW TABLES"'
        docker-compose exec -u $UID db sh -c "$CMD 2>/dev/null" |
        tr -d '\r' |
        grep '^' |
        if [ -n "$1" ]; then grep "$@"; else cat; fi
    }

    ##
    # mysqldumpd
    # for t in $(dc-tables -v oxv_); do echo $t && dc-dump --table $t -C > $t.sql ; done
    ##
    dc-dump() {
        local ARGS=()
        while [ $# -gt 0 ]
        do
        local key="$1"
        case $key in
            --table)
            local TABLE="$2"
            shift # past argument
            shift # past value
            ;;
            *)    # unknown option
            ARGS+=("$1") # save it in an array for later
            shift # past argument
            ;;
        esac
        done
        set -- "${ARGS[@]}" # restore positional parameters

        local CMD='exec mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"'

        docker-compose exec -u $UID db sh -c "$CMD $@ $TABLE 2>/dev/null"
    }

    ##
    # https://github.com/docker-library/docs/tree/master/composer#local-runtimebinary
    ##
    d-composer() {
        local composerHome=${COMPOSER_HOME:-$HOME/.composer}
        mkdir -p ${composerHome}

        local tty= && tty -s && tty=--tty
        docker run \
            $tty \
            --interactive \
            --rm \
            --user $(id -u):$(id -g) \
            --volume ${composerHome}:/tmp \
            --volume /etc/passwd:/etc/passwd:ro \
            --volume /etc/group:/etc/group:ro \
            --volume $(pwd):/app \
            composer "$@"
    }

    d-traefik() {
        docker network inspect traefik > /dev/null 2>&1 || docker network create traefik > /dev/null 2>&1

        docker start traefik 2>/dev/null || docker run -tid --name traefik --net=traefik \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -p 80:80 -p 443:443 -p 8080:8080 \
            traefik:latest \
            --api \
            --logLevel=error \
            --entrypoints='Name:http Address::80' \
            --entrypoints='Name:https Address::443 TLS' \
            --defaultentrypoints=http,https \
            --docker \
            --docker.exposedbydefault=false \
            2>/dev/null
    }
fi