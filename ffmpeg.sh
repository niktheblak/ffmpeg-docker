#!/usr/bin/env bash

docker run \
  -it \
  --rm \
  -v $PWD:/output \
  ffmpeg:latest \
  "$@"
