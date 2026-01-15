FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y locales sudo \
 && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 \
 && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN adduser --disabled-password --gecos '' docker \
 && adduser docker sudo \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get update && apt-get install -y \
    wget bash bc gcc-8 sed patch patchutils tar bzip2 gzip perl gawk gperf zip unzip diffutils texinfo lzop python python3 \
    g++-8 xfonts-utils xfonts-utils xfonts-utils xsltproc default-jre-headless \
    libc6-dev libncurses5-dev \
    u-boot-tools \
    xz-utils make file libxml-parser-perl \
    libjson-perl \
    golang-go \
    git openssh-client \
    --no-install-recommends \
	&& update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8 && \
    update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-8 8 \
 && rm -rf /var/lib/apt/lists/*

ADD .bashrc /home/docker/.bashrc

USER docker
