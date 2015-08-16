#!/bin/bash

# thanks for inspiration to https://github.com/tutumcloud/influxdb/blob/master/0.9/run.sh
set -m

INFLUX_HOST="localhost"
INFLUX_API_PORT="8086"
INFLUX_API_URL="http://${INFLUX_HOST}:${INFLUX_API_PORT}"

CONFIG_FILE="/config/config.toml"


# start influxdb
echo "Start InfluxDB"
exec /opt/influxdb/influxd -config=${CONFIG_FILE} &

#wait for the startup of influxdb
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of InfluxDB service startup ..."
    sleep 3
    curl -k ${INFLUX_API_URL}/ping 2> /dev/null
    RET=$?
done
echo ""

PASS=${INFLUXDB_INIT_PWD:-root}
if [ -n "${ADMIN_USER}" ]; then
    echo "Creating admin"
    /opt/influxdb/influx -host=${INFLUX_HOST} -port=${INFLUX_API_PORT} -execute="CREATE USER ${ADMIN_USER} WITH PASSWORD '${PASS}' WITH ALL PRIVILEGES"
    echo "Creating databases"
    /opt/influxdb/influx -host=${INFLUX_HOST} -port=${INFLUX_API_PORT} -username=${ADMIN_USER} -password="${PASS}" -execute="create database metrics"
    /opt/influxdb/influx -host=${INFLUX_HOST} -port=${INFLUX_API_PORT} -username=${ADMIN_USER} -password="${PASS}" -execute="grant all PRIVILEGES on metrics to ${ADMIN_USER}"
    echo ""
else
    echo "=> Creating database"
    /opt/influxdb/influx -host=${INFLUX_HOST} -port=${INFLUX_API_PORT} -execute="create database \"metrics\""
fi

fg
