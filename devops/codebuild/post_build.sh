#!/bin/sh

set -e

echo $ECR_DOMAIN

aws2 ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_DOMAIN
docker tag technical_challenge_03:latest $ECR_DOMAIN/technical_challenge_03:latest
docker push $ECR_DOMAIN/technical_challenge_03:latest --quiet
