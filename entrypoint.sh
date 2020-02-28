#!/bin/bash
set -e

SQUID_LOG=/var/log/squid3
SQUID_CACHE=/var/spool/squid3
SQUID_USER=proxy

chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_LOG}

mkdir -p ${SQUID_CACHE}
chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_CACHE}

if [[ ! -d ${SQUID_CACHE}/00 ]]; then
    echo "Initializing cache..."
    squid3 -N -z
fi

echo "Starting squid3..."
exec tail -vn 0 -F /var/log/squid3/{cache,access}.log &
exec squid3 -NYCd 1
