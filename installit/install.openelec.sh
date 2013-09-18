#!/bin/bash

URL=http://releases.openelec.tv/OpenELEC-Fusion.x86_64-3.0.6.tar.bz2

wget -q ${URL} -P /tmp/
tar xjf /tmp/${URL##*/} -C /tmp/

cp /tmp/OpenELEC*/target/KERNEL /var/lib/tftpboot/openelec/KERNEL
cp /tmp/OpenELEC*/target/SYSTEM /media/openelec/

if [ $(grep openelec /etc/fstab | wc -l) == 0 ]; then
cat <<EOF>> /etc/fstab
/media/openelec       /export/openelec none    bind  0  0
EOF
fi

if [ $(grep openelec /etc/exports | wc -l) == 0 ]; then
cat <<EOF>> /etc/exports
/export/openelec  192.168.2.0/24(rw,nohide,insecure,no_subtree_check,async)
EOF
fi

if [ -f /var/lib/tftpboot/pxelinux.cfg/openelec.conf ]; then
cat <<EOF> /var/lib/tftpboot/pxelinux.cfg/openelec.conf 
LABEL linux
   MENU LABEL OpenElec 
   KERNEL openelec/KERNEL
   APPEND ip=dhcp boot=NFS=192.168.2.1:/export/openelec disk=NFS=192.168.2.1:/export/openelec/storage overlay ssh
# nosplash
EOF
fi