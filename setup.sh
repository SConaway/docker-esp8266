#!/usr/bin/env bash
#apt install -y

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

RUN rm -rf /opt
git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /opt
useradd -M -s /bin/bash -u 1000 build
usermod -a -G dialout build
echo "build ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/build
chmod 0440 /etc/sudoers.d/build
chown -R build /opt
chgrp -R build /opt

cd /opt
su build -c "make"
#rm -rvf $(ls /opt/ | grep -v xtensa-lx106-elf)
# DEBIAN_FRONTEND=noninteractive apt-get purge -yq
#   git \
#   autoconf \
#   build-essential \
#   gperf \
#   bison \
#   flex \
#   texinfo \
#   libtool \
#   libncurses5-dev \
#   wget \
#   apt-utils \
#   gawk \
#   unzip \
#   libexpat-dev \
#   help2man \
#   python2.7-dev \
DEBIAN_FRONTEND=noninteractive apt-get autoremove -yq --purge
DEBIAN_FRONTEND=noninteractive apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
rm -rf /crosstool-NG/.build/*

PATH=/opt/xtensa-lx106-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

pip install esptool

cd examples/blinky
make
cd ..
