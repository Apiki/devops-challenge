#!/bin/sh

set -e

aws2 ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_DOMAIN
docker tag technical_challenge_03:latest $ECR_DOMAIN/technical_challenge_03:latest
docker push $ECR_DOMAIN/technical_challenge_03:latest --quiet

aws2 ecs update-service --cluster technical-challenge-03 --service technical-challenge-03  --force-new-deployment 1> /dev/null
