FROM lendkey/lkaf

#Notice the base image. It is assumed that you build the LK automation framework from the base Dockerfile with
# the -tlendkey/lkaf flag. This means the base image already has python and selenim and robot, as well as the
# Chrome and Firefox drivers. All we are doing here is inserting Pycharm into that image.

# Use this in conjunction with lendkey/lkaf image to add Pycharm to the image
# and then actually write code for the framework

LABEL maintainer "Hank Birkdale <hank.birkdale@gmail.com>"
# The Pycharm section was originally developed by  Viktor Adam <rycus86@gmail.com>"
# and can be found at https://hub.docker.com/r/rycus86/pycharm/~/dockerfile/


# Set up the basics

#This next line shuts off any questions you might get from the installs
ENV DEBIAN_FRONTEND noninteractive

# Now you need to install a few utilities to include xfce4 for the Linux desktop
RUN apt-get update && apt-get install --no-install-recommends -y \
  wget \
  bzip2 \
  gcc git openssh-client \
  python-dev python-setuptools \
  python3-dev python3-setuptools \
  libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
  libfontconfig1 \
  xfce4 dbus-x11 \
  && rm -rf /var/lib/apt/lists/*
###############################################


### Install Firefox
RUN wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
RUN mkdir /opt/firefox
RUN tar xvjf FirefoxSetup.tar.bz2 -C /opt/firefox/

# RUN ln -s /opt/firefox/firefox/firefox /usr/lib/firefox-esr/firefox-esr
################################################################################

# Install and configure Pycharm
ARG pycharm_source=https://download-cf.jetbrains.com/python/pycharm-community-2017.2.2.tar.gz
ARG pycharm_local_dir=.PyCharmCE2017.2

RUN mkdir /opt/pycharm
WORKDIR /opt/pycharm

ADD $pycharm_source /opt/pycharm/installer.tgz

RUN tar --strip-components=1 -xzf installer.tgz && rm installer.tgz

RUN /usr/bin/python2 /opt/pycharm/helpers/pydev/setup_cython.py build_ext --inplace
RUN /usr/bin/python3 /opt/pycharm/helpers/pydev/setup_cython.py build_ext --inplace
# End install pycharm

# Configure container with 'developer' user
RUN useradd -ms /bin/bash developer
USER developer
ENV HOME /home/developer

RUN mkdir /home/developer/.PyCharm \
  && ln -sf /home/developer/.PyCharm /home/developer/$pycharm_local_dir

### Start the desktop. If on a Mac you will need Quartz running already
CMD startxfce4
# If you want to just start pycharm, then replace the above with the line below
# CMD [ "/opt/pycharm/bin/pycharm.sh" ]
# Pycharm (or the desktop) should work at this point but you will need to have X-windows configured.
# If the machine that has Docker installed on it already has X-windows - it should work reasonably well,
# but you will probably have to edit $DISPLAY. If you are running Docker on a Mac
# you will need to install XQuartz, the X-window lib for Mac. See the instructions in
# the run_docker_python_dev_env.sh script
