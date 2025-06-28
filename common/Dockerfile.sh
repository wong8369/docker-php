#!/usr/bin/env bash

PHP_EXT_GROUP_NONE="" \
 && for PHP_EXT_GROUP__CURRENT in $(echo ${PHP_EXT_GROUP} | tr ",;" " "); do \
        PHP_EXT_GROUP__CURRENT=${PHP_EXT_GROUP__CURRENT^^}; \
        PHP_EXT_GROUP__VAR='PHP_EXT_GROUP_'${PHP_EXT_GROUP__CURRENT}; \
        PHP_EXT="$PHP_EXT ${!PHP_EXT_GROUP__VAR}"; \
    done \
 && PHP_EXT=$(echo ${PHP_EXT} | tr " " "\n" | sort) \
 && PHP_EXT__UNIQ=$(echo ${PHP_EXT} | tr " " "\n" | uniq -u) \
 && PHP_EXT__DUPL=$(echo ${PHP_EXT} | tr " " "\n" | uniq -d) \
 && PHP_EXT=${PHP_EXT__UNIQ}" "${PHP_EXT__DUPL} \
 && PECL_EXT_GROUP_NONE="" \
 && for PECL_EXT_GROUP__CURRENT in $(echo ${PECL_EXT_GROUP} | tr ",;" " "); do \
        PECL_EXT_GROUP__CURRENT=${PECL_EXT_GROUP__CURRENT^^}; \
        PECL_EXT_GROUP__VAR='PECL_EXT_GROUP_'${PECL_EXT_GROUP__CURRENT}; \
        PECL_EXT="$PECL_EXT ${!PECL_EXT_GROUP__VAR}"; \
    done \
 && PECL_EXT=$(echo ${PECL_EXT} | tr ",; " "\n" | sort) \
 && PECL_EXT__UNIQ=$(echo ${PECL_EXT} | tr " " "\n" | uniq -u) \
 && PECL_EXT__DUPL=$(echo ${PECL_EXT} | tr " " "\n" | uniq -d) \
 && PECL_EXT=${PECL_EXT__UNIQ}" "${PECL_EXT__DUPL} \
 && apt-get update \
 && for PHP_EXT__CURRENT in ${PHP_EXT}; do \
        /usr/local/bin/re-php-install-ext ${PHP_EXT__CURRENT}; \
        EXCODE=$?; \
        if [ "${EXCODE}" -gt 0 ]; then \
            exit ${EXCODE}; \
        fi; \
    done \
 && for PECL_EXT__CURRENT in ${PECL_EXT}; do \
        /usr/local/bin/re-pecl-install-ext ${PECL_EXT__CURRENT} \
        EXCODE=$?; \
        if [ "${EXCODE}" -gt 0 ]; then \
            exit ${EXCODE}; \
        fi; \
    done