#!/bin/sh

set -e

sudo service nginx start

docker-entrypoint.sh apache2-foreground
