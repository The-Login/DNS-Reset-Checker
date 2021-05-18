#!/bin/bash

if [[ $# != 2 ]] ; then
    echo 'Please supply the domain name and IP address of this authoritative nameserver!'
    echo 'Usage: ./start.sh domain.example 203.0.113.37'
    exit 1
fi

export NS_DOMAIN=$1
export NS_IP=$2
docker-compose up -d --no-deps --build
