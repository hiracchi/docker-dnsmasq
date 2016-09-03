FROM hiracchi/ubuntu-ja-supervisor
MAINTAINER Toshiyuki HIRANO <hiracchi@gmail.com>

# packages install (openssh)
RUN apt-get update && \
    apt-get install -y dnsmasq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# setup dnsmasq
RUN mkdir -p /var/run/dnsmasq
COPY resolv.conf /var/run/dnsmasq/resolv.conf
RUN sed -i \
  -e 's/#addn-hosts.*$/addn-hosts=\/etc\/add-hosts/' \
  -e 's/#user=.*$/user=root/' \
  /etc/dnsmasq.conf
# -e 's/#bind-interfaces/bind-interfaces/'
# -e 's/#expand-hosts/expand-hosts/'
# -e 's/#bogus-priv/bogus-priv/'
# -e 's/#domain-needed/domain-needed/'

RUN mkdir -p /work 
RUN touch /work/add-hosts && ln -snf /work/add-hosts /etc/add-hosts

# for service
COPY dnsmasq.conf /etc/supervisor/conf.d/dnsmasq.conf

EXPOSE 53 53/udp
ENTRYPOINT ["/usr/bin/supervisord"]

