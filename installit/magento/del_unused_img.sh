#!/bin/bash

LOG=/var/log/magento/del_unused_img.log

. /etc/magento/magento.conf

function search_db() {
    COUNT=$(mysql -u ${DB_USER} -p${DB_PASS} ${DB_NAME} --execute="SELECT count(*) FROM catalog_product_entity_media_gallery WHERE value = \"$1\"")

    echo $(echo ${COUNT} | cut -d" " -f2)
}

echo $(date) | tee -a ${LOG}

for IMG in $(find /var/www/media/catalog/product/ -name '*.jpg' ! -path '*cache*' ! -name 'google*'); do
    # search in db
    if [ $(search_db ${IMG/'/var/www/media/catalog/product'/}) != 1 ]; then
        IMG=${IMG##*/}
        for CACHE_IMG in $(find /var/www/media/catalog/product/ -name "${IMG}"); do
            echo "${CACHE_IMG}" | tee -a ${LOG}
            
            rm "${CACHE_IMG}"
        done

        echo "" | tee -a ${LOG}
    fi
done
