#!/bin/sh

set -e

docker build \
  --file devops/codebuild/Dockerfile \
  --tag technical_challenge_03 \
  --quiet .
