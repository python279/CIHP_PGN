REPO?=harbor.uat.enflame.cc/library/enflame.cn/cihp_pgn
TAG?=$(shell git rev-parse --abbrev-ref HEAD | sed -e 's/\//-/g')
build:
	docker build . --network host --file Dockerfile --tag $(REPO):$(TAG)
push:
	docker push $(REPO):$(TAG)
all: build push
