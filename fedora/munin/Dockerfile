FROM fedora:22

MAINTAINER Marian Sievers <info@mariansievers.de>

# update system
RUN dnf update -y

# install munin
RUN dnf install -y munin munin-node

COPY munin.conf /etc/munin/munin.conf
COPY munin-node.conf /etc/munin/munin-node.conf
RUN mkdir /var/www/munin && chown munin:munin /var/www/munin

VOLUME /var/www/munin

CMD munin
