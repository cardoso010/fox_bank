#!/usr/bin/make -f

# Take the last commit hash
COMMIT=$(shell git rev-parse --verify HEAD)
VERSION=$(shell cat VERSION)

build_image:
	docker image build -f "Dockerfile" . -t "fox_bank:latest" -t "fox_bank:$(VERSION)"

tag_image: 
	docker image tag fox_bank:latest cardoso010/fox_bank:$(VERSION)

push_image: 
	docker push cardoso010/fox_bank:latest