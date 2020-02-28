FROM        debian:jessie

LABEL       MAINTAINER "Daniel Rodrigo Fleck <danielflck@gmail.com>"

ENV         DEBIAN_FRONTEND noninteractive

RUN         set -x \
            && apt-get -qq update \
            && apt-get install -yq --no-install-recommends squid3 \
            && apt-get purge -y --auto-remove

RUN         chmod  +rwx /proc/self/fd/1

COPY        ./squid.conf /etc/squid3/squid.conf

ADD         ./entrypoint.sh /entrypoint.sh 

VOLUME      /etc/squid3/

ENTRYPOINT  ["/bin/bash", "-c", "/entrypoint.sh"]

CMD         ["squid3"]

EXPOSE      3128
