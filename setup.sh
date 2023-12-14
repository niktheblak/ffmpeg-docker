#!/usr/bin/env bash

if [[ -z "$FFMPEG_VERSION" ]]; then
  FFMPEG_VERSION=6.0.1
fi

set -e

export DEBIAN_FRONTEND=noninteractive

apt update
apt-get -yq install build-essential curl gnupg unzip bzip2 nasm \
  libfdk-aac-dev gpac libavcodec58 libavdevice58 libavfilter7 libavformat58 \
  libavutil56 libc6 libpostproc55 libsdl2-2.0-0 libswresample3 libswscale5 \
  libx265-dev libx264-dev libaom-dev libvorbis-dev libmp3lame-dev \
  libsvtav1-dev libsvtav1dec-dev libsvtav1enc-dev
rm -r /var/lib/apt/lists/*

cd
curl -sSl -O "https://www.ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.bz2"
curl -sSl -O "https://www.ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.bz2.asc"
curl -sSl https://www.ffmpeg.org/ffmpeg-devel.asc | gpg --import
gpg --verify "ffmpeg-$FFMPEG_VERSION.tar.bz2.asc"
tar xjf "ffmpeg-$FFMPEG_VERSION.tar.bz2"
pushd .
cd "ffmpeg-$FFMPEG_VERSION"
./configure \
  --enable-nonfree \
  --enable-gpl \
  --enable-libfdk-aac \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libsvtav1 \
  --enable-libmp3lame \
  --enable-libvorbis \
  --disable-ffplay
make -j$(nproc)
make install
popd
rm -r "ffmpeg-$FFMPEG_VERSION"
rm "ffmpeg-$FFMPEG_VERSION.tar.bz2" "ffmpeg-$FFMPEG_VERSION.tar.bz2.asc"
