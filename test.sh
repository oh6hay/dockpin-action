#!/bin/bash

if [ -z "$1" ] ; then
    echo "usage: $0 [ build | test ]"
    exit 1
fi

tag=docker-action-test

if [ "$1" == "build" ] ; then
    docker build -t $tag .
elif [ "$1" == "shell" ] ; then
    docker run -v /var/run/docker.sock:/var/run/docker.sock --rm -it $tag /bin/bash
elif [ "$1" == "test" ] ; then
    docker run -v `pwd`:/tmp -v /var/run/docker.sock:/var/run/docker.sock --rm -t $tag /bin/entrypoint.sh /tmp/Dockerfile
fi
