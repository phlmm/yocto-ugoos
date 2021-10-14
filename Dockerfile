FROM ubuntu:focal
MAINTAINER Neil Armstrong <narmstrong@baylibre.com>
LABEL Description=" This image is for building meta-meson inside a container"

# Make sure apt is happy
ENV DEBIAN_FRONTEND=noninteractive

# Update packages
RUN apt update -qq

# Install OE dependencies
RUN apt install -qq -y  gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd lz4
    
# Install git
RUN apt-get install -qq git


# Add missing libz for linaro gcc
RUN apt-get install -qq zlib1g:i386

# Setup system
RUN apt-get install -qq locales
RUN locale-gen en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Use en_US.UTF-8 locale
ENV LANG=en_US.UTF-8

# Add and use the yocto user
RUN useradd -c 'yocto user' -m -d /home/yocto -s /bin/bash yocto
USER yocto
ENV HOME /home/yocto
