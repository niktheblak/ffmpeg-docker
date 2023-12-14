FROM ubuntu:latest

ARG FFMPEG_VERSION=6.0.1
ENV FFMPEG_VERSION=${FFMPEG_VERSION}

COPY setup.sh .

RUN ./setup.sh

VOLUME /output
WORKDIR /output
ENTRYPOINT ["/usr/local/bin/ffmpeg"]
