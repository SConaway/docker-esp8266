#!/usr/bin/env bash
# shellcheck disable=SC2164

set -ex

DEBIAN_FRONTEND=noninteractive apt-get update -qq

DEBIAN_FRONTEND=noninteractive apt-get install -yq \
  git \
  build-essential \
  wget \
  gperf \
  make \
  autoconf \
  automake \
  apt-utils \
  gawk \
  sudo \
  bison \
  flex \
  texinfo \
  help2man \
  gawk \
  python \
  python-dev \
  python-serial \
  python-pip \
  bash \
  sed \
  libtool \
  libtool-bin \
  libncurses5-dev

rm -rf /opt
git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /opt
useradd -M -s /bin/bash -u 1000 build
usermod -a -G dialout build
echo "build ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/build
chmod 0440 /etc/sudoers.d/build
chown -R build /opt
chgrp -R build /opt

cd /opt
su build -c "make"
DEBIAN_FRONTEND=noninteractive apt-get purge -yq \
  apt-utils \
  autoconf \
  automake \
  bison \
  flex \
  g++ \
  gcc \
  git \
  help2man \
  libncurses5-dev \
  libtool \
  python-dev \
  texinfo \
  wget
DEBIAN_FRONTEND=noninteractive apt-get autoremove -yq --purge
DEBIAN_FRONTEND=noninteractive apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
rm -rf /opt/crosstool-NG
rm -rf /opt/.git

PATH=/opt/xtensa-lx106-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

pip install esptool

cd examples/blinky
make
rm blinky.o blinky-0x00000.bin  blinky-0x10000.bin
cd ..
