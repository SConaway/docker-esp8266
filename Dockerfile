FROM ubuntu:18.04

MAINTAINER Steven Conaway steven.conaway@icloud.com

COPY setup.sh /

RUN bash /setup.sh

ENV PATH=/opt/xtensa-lx106-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENTRYPOINT ["/bin/bash"]
