FROM fedora:22
MAINTAINER Marian Sievers <info@mariansievers.de>

ENV INFLUXDB_VERSION=0.9.2-1

# install influxdb
RUN curl -o influxdb-$INFLUXDB_VERSION.x86_64.rpm https://s3.amazonaws.com/influxdb/influxdb-$INFLUXDB_VERSION.x86_64.rpm
RUN dnf install -y influxdb-$INFLUXDB_VERSION.x86_64.rpm

# copy run-file
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 8083 8086 8096

CMD /run.sh
