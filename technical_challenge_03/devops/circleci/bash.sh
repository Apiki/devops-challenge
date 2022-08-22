#!/bin/sh

set -e

docker run \
  --volume "${PWD}:/home/circleci/technical_challenge_03" \
  --workdir "/home/circleci/technical_challenge_03" \
  --rm -it cimg/php:8.1.9 bash
