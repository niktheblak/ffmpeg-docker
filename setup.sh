#!/usr/bin/env bash

if [[ -z "$FFMPEG_VERSION" ]]; then
  FFMPEG_VERSION=7.0.2
fi

set -e

tee -a /etc/apt/sources.list.d/ubuntu-src.sources <<EOF

Types: deb-src
URIs: http://ports.ubuntu.com/ubuntu-ports/
Suites: noble noble-updates noble-backports
Components: main universe restricted multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

EOF

apt-get update
apt-get -y build-dep ffmpeg
DEBIAN_FRONTEND=noninteractive apt-get -y install \
  curl \
  ca-certificates \
  gnupg \
  libsvtav1-dev \
  libsvtav1dec-dev \
  libsvtav1enc-dev \
  libfdk-aac-dev \
  libx265-dev \
  libx264-dev \
  libaom-dev
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
