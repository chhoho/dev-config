#/bin/sh

#
# deprecated
# use: http://boot.panticz.de/run.sh
#

# use local apt-cacher if available
ping -c 1 apt-cacher > /dev/null
if [ $? -eq 0 ]; then
  debconf-set mirror/http/proxy "http://apt-cacher:3142/"
fi

# auto partitioning
#if [ $(cat /proc/cmdline | grep autopart | wc -l) -eq 1 ]; then
  debconf-set preseed/include "autopart.cfg"
#fi
