IMAGE_NAME = rotespferd/fedora-influxdb
CONTAINER_NAME = influxdb

default:
	echo "Hello World!"

build:
	docker build --rm=true -t $(IMAGE_NAME) .

run:
	docker run --name="$(CONTAINER_NAME)" -d -p 8083:8083 -p 8086:8086 --expose 8090 --expose 8099 $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)

clean: stop
	docker rm $(CONTAINER_NAME)
