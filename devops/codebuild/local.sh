#!/bin/sh

set -e

docker pull public.ecr.aws/codebuild/amazonlinux2-x86_64-standard:4.0 &&
  docker pull public.ecr.aws/codebuild/local-builds:latest &&
  docker inspect public.ecr.aws/codebuild/local-builds:latest &&
  wget -O devops/codebuild/exec.sh https://raw.githubusercontent.com/aws/aws-codebuild-docker-images/master/local_builds/codebuild_build.sh &&
  chmod +x devops/codebuild/exec.sh &&
  sed -i "s/docker run -it/docker run --rm -it/g" devops/codebuild/exec.sh &&
 ./devops/codebuild/exec.sh -i public.ecr.aws/codebuild/amazonlinux2-x86_64-standard:4.0 -p default -e devops/codebuild/.env -cd -a .

