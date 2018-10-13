# This script needs some work. The issue is the "DISPLAY" flag below.
# Technically, DISPLAY is usually set as an env variable on Linux, but not on a Mac
# and is related to X-Win. What this script needs is:
# 1. Get the value of $DIPLAY
# 2. If it's blank - you probably have some work today
#     - Get the OS
#       - if Mac - Get the ipaddress
#               -- Need to also make sure Xquartz is running and xhost + is set to allow connections
#       - If Linus - Not sure but I think the value is somewhere in the /tmp/.X11-unix fileset
#     - Set $DISPLAY and replace my hardcoded ip address below
#     In the interim - if you are running on a Mac, just get your ip address en0 and replace mine below.

#Set up some parameters
root_home="/Users/hbirkdale/Development/Python"
# Run xhost
#xhost
#xhost + 127.0.0.1

docker run -it \
  -e DISPLAY=docker.for.mac.localhost:0 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ${HOME}/.Xauthority:/home/developer/.Xauthority \
  -v $root_home/.Pycharm:/home/developer/.PyCharm \
  -v $root_home/:/home/developer \
 hbirkdale/pycharm:latest
