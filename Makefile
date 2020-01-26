
all: build push
.PHONY: all

build:
	./hack/build.sh

push:
	./hack/push.sh
