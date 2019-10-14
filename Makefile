
all: build push
.PHONY: all

build:
	./build.sh

push:
	./push.sh
