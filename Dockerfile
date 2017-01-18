#####################################################################
#																	#
#			Dockerfile template for node.js sails.js				#
#																	#
#####################################################################

FROM ubuntu:16.04

MAINTAINER ctc316 <mike.tc.chen101@gmail.com>

USER root

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update \
	&& apt-get -y install curl

# nvm & nodejs
ENV NVM_VERSION=0.33.0	\
	NVM_DIR=$HOME/.nvm \
	NODE_VERSION=6.9.4

RUN	curl -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash \
	&& source $NVM_DIR/nvm.sh \
	&& nvm install $NODE_VERSION 	\
	&& nvm use $NODE_VERSION 	\
	&& nvm alias default $NODE_VERSION

#ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules/
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Sails.js
ENV SAILS_VERSION=0.12.11
RUN npm -g install sails@$SAILS_VERSION


# Build image
VOLUME /srv/docker-nodejs-sails
WORKDIR /srv/docker-nodejs-sails
EXPOSE 1337
CMD sails lift