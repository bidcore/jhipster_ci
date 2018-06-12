# JHipster CI for use within Gitlab Runners
# Base on JDK 8
# (c) BiDcore

FROM openjdk:8

MAINTAINER Holger Berndt <hberndt@bidcore.de>

# Update OS and install some packages
RUN apt-get update && apt-get install -y \
         apt-transport-https \
         ca-certificates \
         curl \
         gnupg2 \
         software-properties-common \
   # download Docker GPG Key and install it in APT
   && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
   # add the docker repository
   && add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable" \
   # update repository and install docker
   && apt-get update && \
      apt-get install -y docker-ce

# copy the script to bin directory
COPY docker-entrypoint.sh /usr/bin/

# set the entrypoint and end with shell
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
CMD ["sh"]
