#!/bin/bash

docker run \
  -it \
  --rm \
  -v $PWD/output:/output \
  ffmpeg:latest \
  "$@"
