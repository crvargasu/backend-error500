#!/bin/sh
docker-compose build
docker-compose run web rails db:drop
docker-compose run web rails db:create
docker-compose run web rails db:migrate
docker-compose run web rails db:seed
