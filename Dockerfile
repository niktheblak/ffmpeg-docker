FROM ubuntu:24.04

ARG FFMPEG_VERSION=7.0.2
ENV FFMPEG_VERSION=${FFMPEG_VERSION}

COPY setup.sh .

RUN ./setup.sh

VOLUME /output
WORKDIR /output
ENTRYPOINT ["/usr/local/bin/ffmpeg"]
