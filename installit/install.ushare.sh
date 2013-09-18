#!/bin/bash

# install
apt-get install -y ushare
 
# change rc order
update-rc.d -f ushare remove
update-rc.d ushare defaults 99
 
# configure network
echo "post-up route add -net 239.0.0.0 netmask 255.0.0.0 eth0" >> /etc/network/interfaces
 
# OPTIONAL: configure ushare
sed -i '22s|USHARE_DIR=|USHARE_DIR=/media/mp3,/media/video,/media/images|g' /etc/ushare.conf 
 
# restart services
service ushare networking
service ushare restart