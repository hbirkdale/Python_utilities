FROM hbirkdale/python

#Notice the base image. It is assumed that you build this based off of a base image that already
# has Python installed and you build that image with the -thbirkdale/python flag. 
# All we are doing here is inserting Pycharm into that image.

LABEL maintainer "Hank Birkdale <hank.birkdale@gmail.com>"
# The Pycharm section was originally developed by  Viktor Adam <rycus86@gmail.com>"
# and can be found at https://hub.docker.com/r/rycus86/pycharm/~/dockerfile/

# Set up the basics

#This next line shuts off any questions you might get from the installs
ENV DEBIAN_FRONTEND noninteractive

#Set up some parameters
ENV PYCHARM_HOME=/etc/pycharm
ARG pycharm_source=https://download-cf.jetbrains.com/python/pycharm-community-2017.2.2.tar.gz

# Install the basics
# You need to be root to install things
USER root
RUN apt-get update &&\
    apt-get install -y \
    wget \
    git \
    default-jre \
    libxrender1 \
    libxtst6 \
    --no-install-recommends


RUN wget $pycharm_source -O /tmp/pycharm.tar.gz 
RUN mkdir ${PYCHARM_HOME} 
RUN tar -xzvf /tmp/pycharm.tar.gz -C ${PYCHARM_HOME} --strip=1 
RUN wget -P /tmp/ https://bootstrap.pypa.io/get-pip.py 
RUN python /tmp/get-pip.py 
RUN rm -rf /var/lib/apt-lists; rm -rf /tmp/*; apt-get purge wget -y; apt-get autoremove -y

# You want to switch back to developer so Pycharm remembers who you are
# Note that developer already exists because we are basing this off of hbirkdale/python
USER developer 

ENTRYPOINT ["/etc/pycharm/bin/pycharm.sh"]
