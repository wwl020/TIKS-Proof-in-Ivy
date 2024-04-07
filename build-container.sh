#!/bin/sh
set -e
docker build --target ivy-docker -t ivy-docker/tiks -f ./Dockerfile .