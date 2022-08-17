#!/bin/sh

set -e

docker volume rm -f technical_challenge_03_app_local technical_challenge_03_mysql_data
docker image rm -f technical_challenge_03_app
