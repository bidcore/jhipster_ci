# JHipster CI for use within Gitlab Runners
# Base on JDK 8
# (c) BiDcore

FROM openjdk:8

MAINTAINER Holger Berndt <hberndt@bidcore.de>

RUN \
  #install dependencies
  apt-get update && \
  apt-get install -y \
    python \
    g++ \
    build-essential && \
  # install latest Node.js and npm
  # https://gist.github.com/isaacs/579814#file-node-and-npm-in-30-seconds-sh
  mkdir ~/node-latest-install && cd $_ && \
  curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1 && \
  make install && \
  curl https://www.npmjs.org/install.sh | sh && \
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
