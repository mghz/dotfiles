#!/usr/bin/env sh

docker-compose -f dc-postgres.yml up -d
docker-compose -f dc-adminer.yml up -d
