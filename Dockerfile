# Work in progress
# docker build -t usvisa-il-app .
# docker run --env-file .env -v $PWD:/shared/ --rm usvisa-il-app
FROM python:3.8.7-slim
MAINTAINER Avi Friedman

ARG GECKO_VERSION=0.30.0

COPY . /usvisa-il-app
WORKDIR /usvisa-il-app

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y --no-install-recommends firefox-esr xvfb wget ruby-full
RUN wget https://github.com/mozilla/geckodriver/releases/download/v${GECKO_VERSION}/geckodriver-v${GECKO_VERSION}-linux64.tar.gz
RUN tar -C /usr/local/bin/ -xvf geckodriver-v${GECKO_VERSION}-linux64.tar.gz
RUN rm geckodriver-v${GECKO_VERSION}-linux64.tar.gz
RUN pip3 install wheel
#RUN pip3 install python-telegram-bot==13.1
RUN pip3 install emoji==1.2.0
RUN pip3 install selenium==4.0.0
RUN pip3 install pyvirtualdisplay==2.2
#RUN pip3 install -r requirements.txt
RUN chmod +x ./src/main.py

CMD ["./src/main.py"]
