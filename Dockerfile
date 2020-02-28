FROM        ubuntu:16.04

LABEL       MAINTAINER "Daniel Rodrigo Fleck <danielflck@gmail.com>"

ENV         DEBIAN_FRONTEND noninteractive

RUN         set -x \
            && apt-get -qq update \
            && apt-get install -yq --no-install-recommends squid3 \
            && apt-get purge -y --auto-remove

ADD         entrypoint.sh /root/entrypoint.sh

VOLUME      /etc/squid/

EXPOSE      3128

CMD  ["/bin/bash /root/entrypoint.sh"]
