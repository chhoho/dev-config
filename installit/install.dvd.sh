#!/bin/bash

# add repository
sudo wget http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list -O /etc/apt/sources.list.d/medibuntu.list

# update repository
sudo apt-get update -qq

# get keyring
sudo apt-get -y --force-yes install medibuntu-keyring

# install libdvdcss
sudo apt-get install -y --force-yes libdvdcss2
