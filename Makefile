REPO=blacktop
NAME=kibana
BUILD ?= 5.2
LATEST ?= 5.2

all: build size test

build:
	cd $(BUILD); docker build -t $(REPO)/$(NAME):$(BUILD) .

size: build
ifeq "$(BUILD)" "$(LATEST)"
	sed -i.bu 's/docker image-.*-blue/docker image-$(shell docker images --format "{{.Size}}" $(REPO)/$(NAME):$(BUILD))-blue/' README.md
	sed -i.bu '/latest/ s/[0-9.]\{3,5\} MB/$(shell docker images --format "{{.Size}}" $(REPO)/$(NAME):$(BUILD))/' README.md
endif
	sed -i.bu '/$(BUILD)/ s/[0-9.]\{3,5\} MB/$(shell docker images --format "{{.Size}}" $(REPO)/$(NAME):$(BUILD))/' README.md

tags:
	docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" $(REPO)/$(NAME)

test:
	docker run --rm $(REPO)/$(NAME):$(BUILD)

.PHONY: build size tags test
