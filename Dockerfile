FROM python:3-alpine

# MAINTAINER Jim McVea <jmcvea@gmail.com>
LABEL maintainer="Per Bergland <per@refapp.se>"

LABEL Description="Provides openstack client tools" Version="0.1"

# Packages in addition to openstack core
ARG OPENSTACK_PACKAGES="python-barbicanclient python-octaviaclient"

RUN python -m ensurepip

RUN apk add --update \
  ca-certificates \
  gcc  \
  libffi-dev \
  openssl-dev \
  musl-dev \
  linux-headers \
  && pip install --upgrade --no-cache-dir pip setuptools python-openstackclient ${OPENSTACK_PACKAGES} \
  && apk del gcc musl-dev linux-headers libffi-dev \
  && rm -rf /var/cache/apk/*

# Add a volume so that a host filesystem can be mounted 
# Ex. `docker run -v $PWD:/data jmcvea/openstack-client`
VOLUME ["/data"]

# Default is to start a shell.  A more common behavior would be to override
# the command when starting.
# Ex. `docker run -ti jmcvea/openstack-client openstack server list`
CMD ["/bin/sh"]

