# JHipster CI for use within Gitlab Runners
# Base on JDK 8
# (c) BiDcore

FROM openjdk:8

MAINTAINER Holger Berndt <hberndt@bidcore.de>

ENV NODE_VERSION 8.11.2
ENV ARCH=x64

RUN \
  #install dependencies
  apt-get update && \
  apt-get install -y \
    python

RUN \
  # f = fail
  # O = use remote file name
  # L = redo if location changed
  # s = silent
  # S = show errors
  curl -fsSLO --compressed "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${ARCH}.tar.xz" && \
  tar -xJf "node-v${NODE_VERSION}-linux-${ARCH}.tar.xz" -C /usr/local --strip-components=1 --no-same-owner && \
  rm "node-v${NODE_VERSION}-linux-${ARCH}.tar.xz" && \
  ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
  curl -fsSLO https://www.npmjs.org/install.sh | sh && \
  # upgrade npm
  npm install -g npm && \
  # install bower gulp yarn
  npm install -g \
    bower \
    gulp-cli \
    yarn && \
  echo '{ "allow_root": true }' > /root/.bowerrc

# installing docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-get -y install apt-transport-https ca-certificates curl software-properties-common && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce
