FROM ubuntu:24.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
    && add-apt-repository ppa:ubuntuhandbook1/ffmpeg7 \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpeg \
    && rm -rf /var/lib/apt/lists/* \
    && apt clean

VOLUME /output
WORKDIR /output

ENTRYPOINT ["/usr/bin/ffmpeg"]
