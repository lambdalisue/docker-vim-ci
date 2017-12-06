# https://github.com/gliderlabs/docker-alpine/issues/362
FROM alpine:3.6
MAINTAINER lambdalisue <lambdalisue@hashnote.net>

# Install build dependencies and required packages
# and Build Vim
ARG BRANCH=${BRANCH:-master}
RUN apk add --no-cache --virtual build-deps curl git make g++ ncurses-dev \
 && apk add --no-cache ncurses \
 && git clone --depth 1 --single-branch --branch ${BRANCH} https://github.com/vim/vim \
 && cd vim \
 && ./configure --enable-fail-if-missing --with-features=huge \
 && make \
 && make install \
 && cd ../ && rm -rf vim \
 && apk del build-deps

ENTRYPOINT ["/usr/local/bin/vim"]
CMD []
