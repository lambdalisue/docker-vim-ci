FROM alpine:latest
MAINTAINER lambdalisue <lambdalisue@hashnote.net>

# Install build dependencies and required packages
# and Build Vim
# 'diffutils' is required while busybox's diff supports
# only unified diff style
# https://busybox.net/downloads/BusyBox.html
ARG OPTIONS
RUN apk add --no-cache --virtual build-deps curl git make g++ ncurses-dev \
 && apk add --no-cache ncurses diffutils \
 && git clone --depth 1 --single-branch $OPTIONS https://github.com/vim/vim \
 && cd vim \
 && git log -1 \
 && ./configure --enable-fail-if-missing --with-features=huge \
 && make \
 && make install \
 && cd ../ && rm -rf vim \
 && apk del build-deps

VOLUME /mnt/volume
WORKDIR /mnt/volume
ENTRYPOINT ["/usr/local/bin/vim"]
CMD []
