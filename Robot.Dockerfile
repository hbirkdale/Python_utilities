FROM ubuntu:latest
# Forked from ypasmk@gmail.com
MAINTAINER "Hank Birkdale" <hank.birkdale@lendkey.com>

LABEL name="Docker build for acceptance testing using the robot framework"

RUN apt-get update
RUN apt-get install -y build-essential libssl-dev libffi-dev python-dev
RUN apt-get install -y python-pip python-dev gcc phantomjs firefox
RUN apt-get install -y xvfb zip wget

RUN apt-get update && apt-get install -y libnss3-dev libxss1 libappindicator1 libindicator7 gconf-service libgconf-2-4 libpango1.0-0 xdg-utils fonts-liberation

RUN pip install --upgrade pip
RUN pip install robotframework
RUN pip install robotframework-sshlibrary
RUN pip install robotframework-selenium2library
RUN pip install -U robotframework-httplibrary
RUN pip install -U requests && pip install -U robotframework-requests
RUN pip install robotframework-xvfb
RUN pip install certifi
RUN pip install urllib3[secure]
RUN pip install robotframework-excellibrary
RUN pip install openpyxl
RUN pip install pyyaml

RUN apt-get install libappindicator3-1 libindicator3-7
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz
RUN tar xvzf geckodriver-v0.11.1-linux64.tar.gz
RUN rm geckodriver-v0.11.1-linux64.tar.gz
RUN cp geckodriver /usr/local/bin && chmod +x /usr/local/bin/geckodriver
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb
RUN wget https://chromedriver.storage.googleapis.com/2.34/chromedriver_linux64.zip && unzip chromedriver_linux64.zip
RUN cp chromedriver /usr/local/bin && chmod +x /usr/local/bin/chromedriver

# Add requirements.txt before rest of repo for caching
ADD requirements.txt /Automation/
WORKDIR /Automation
RUN pip install -r requirements.txt

ADD . /Automation


# RUN apt-get install -y udev

#CMD ["Utils/run_suite.sh"]
#CMD [echo PWD]
#CMD ["./run_suite.sh"]
