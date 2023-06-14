build:
	go build
	mkdir -p output
	mv go-api-helloworld output/api

image:
	docker build . -t osvaldomargato/dummy-api-products:1.0.0

push:
	docker push osvaldomargato/dummy-api-products:1.0.0