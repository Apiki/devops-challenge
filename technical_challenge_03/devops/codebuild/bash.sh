#!/bin/sh

set -e

docker run --rm -it --privileged public.ecr.aws/codebuild/amazonlinux2-x86_64-standard:4.0 bash
