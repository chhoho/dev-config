#!/bin/sh

id >> /root/debug

if [ $@ > 0 ]; then
    LOCALE=$1
else
    LOCALE=en_US.UTF-8
fi

echo ${LOCALE} >> /root/debug

cat <<EOF> /etc/default/locale
LANGUAGE=${LOCALE}
LANG=${LOCALE}
LC_ALL=${LOCALE}
LC_MESSAGES=${LOCALE}
EOF

echo end >> /root/debug