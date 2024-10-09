#!/usr/bin/env bash

FFMPEG_VERSION=7.0.2

docker build \
  --build-arg "FFMPEG_VERSION=$FFMPEG_VERSION" \
  -t ffmpeg:latest \
  .
