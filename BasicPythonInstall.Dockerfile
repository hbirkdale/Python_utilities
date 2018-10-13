FROM debian:stretch

LABEL maintainer "Hank Birkdale <hank.birkdale@gmail.com>"

# Install Python2 and 3 for Debian
RUN apt-get update && apt-get install --no-install-recommends -y \
  wget \
  bzip2 \
  python python-dev python-setuptools python-pip \
  python3 python3-dev python3-setuptools python3-pip \
  && rm -rf /var/lib/apt/lists/*
###############################################

RUN python3 -m pip install flake8

# Configure container with 'developer' user
RUN useradd -ms /bin/bash developer
USER developer
ENV HOME /home/developer

### Start the shell
CMD bash
