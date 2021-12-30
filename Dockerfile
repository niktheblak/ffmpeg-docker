FROM debian:latest

RUN apt update \
  && apt install -y -q ffmpeg \
  && rm -r /var/cache/apt/

VOLUME /output
WORKDIR /output
ENTRYPOINT ["/usr/bin/ffmpeg"]
