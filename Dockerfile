FROM ubuntu:26.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpeg \
    && apt clean

VOLUME /output
WORKDIR /output

ENTRYPOINT ["/usr/bin/ffmpeg"]
