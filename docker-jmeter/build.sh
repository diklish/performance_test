#!/bin/bash

JMETER_VERSION="5.4.1"

# Example build line
# --build-arg IMAGE_TIMEZONE="Europe/Amsterdam"
sudo docker build --build-arg IMAGE_TIMEZONE="Asia/Novosibirsk"  --build-arg JMETER_VERSION=${JMETER_VERSION} -t "docker-jmeter:${JMETER_VERSION}" .
