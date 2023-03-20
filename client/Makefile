all: build run

build: Dockerfile
	# --progress=plain
	docker build -t grpc-client:latest .

run: Dockerfile
	docker run grpc-client:latest
