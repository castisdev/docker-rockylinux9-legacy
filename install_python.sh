#!/bin/sh -e
set -x #echo on
#yum module install -y python39
yum install -y python3-pip
pip3 install -U pip setuptools websocket-client
