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

docker run --rm \
  -e DISPLAY=10.1.9.151:0 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /private/tmp/com.apple.launchd.pSRoluUcKy:/private/tmp/com.apple.launchd.pSRoluUcKy \
  -v ${HOME}/.Xauthority:/home/developer/.Xauthority \
  -v ~/.PyCharm:/home/developer/.PyCharm \
  -v ~/.PyCharm.java:/home/developer/.java \
  -v ~/.PyCharm.py2:/udockersr/local/lib/python2.7 \
  -v ~/.PyCharm.py3:/usr/local/lib/python3.4 \
  -v ~/Development/Python/:/home/developer \
  --name pycharm-$(head -c 4 /dev/urandom | xxd -p)-$(date +'%Y%m%d-%H%M%S') \
 hbirkdale/pythondevgui:latest
