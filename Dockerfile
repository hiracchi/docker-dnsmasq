FROM alpine:3.5
MAINTAINER Toshiyuki HIRANO <hiracchi@gmail.com>


RUN apk update \
  && apk add --no-cache dnsmasq \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /run/nginx


COPY docker-entrypoint.sh /
EXPOSE 53 53/udp
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/dnsmasq", "--keep-in-foreground", "--conf-dir=/etc/dnsmasq.d"]
