#!/bin/bash

set -x
uname -a

apt-get -y install libglib2.0-dev libgtk3.0-dev libgtkdatabox-dev libmatio-dev libfftw3-dev libxml2 libxml2-dev bison
apt-get -y install flex libavahi-common-dev libavahi-client-dev libcurl4-openssl-dev libjansson-dev cmake libaio-dev libserialport-dev

dpkg -i ./download/*.deb
