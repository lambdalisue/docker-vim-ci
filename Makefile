LANG  := C
CYAN  := \033[36m
GREEN := \033[32m
RESET := \033[0m
IMAGE := lambdalisue/vim-ci
TAG   := latest

ifeq (${TAG},latest)
    OPTIONS :=
else
    OPTIONS := --branch ${TAG}
endif

# http://postd.cc/auto-documented-makefile/
.DEFAULT_GOAL := help
.PHONY: help
help: ## Show this help
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "${CYAN}%-30s${RESET} %s\n", $$1, $$2}'

.PHONY: image

image: ## Build a docker image
	@echo "${GREEN}Building a docker image (${IMAGE}:${TAG}) of Vim ${BRANCH}${RESET}"
	@docker build --no-cache --build-arg OPTIONS="${OPTIONS}" -t ${IMAGE}:${TAG} .

.PHONY: pull
pull: ## Pull a docker image
	@echo "${GREEN}Pulling a docker image (${IMAGE}:${TAG})${RESET}"
	@docker pull ${IMAGE}:${TAG}


.PHONY: push
push: ## Push a docker image
	@echo "${GREEN}Pushing a docker image (${IMAGE}:${TAG})${RESET}"
	@docker push ${IMAGE}:${TAG}

.PHONY: all
all: ## All
	# @make image push
	# @make TAG=v8.0.0000 image push
	# @make TAG=v8.0.0027 image push
	# @make TAG=v8.0.0105 image push
	# @make TAG=v8.0.0107 image push
	# @make TAG=v8.0.1383 image push
	# @make TAG=v8.1.0000 image push
	# @make TAG=v8.1.0342 image push
	# @make TAG=v8.1.0349 image push
	# @make TAG=v8.1.0367 image push
	@make TAG=v8.1.2000 image push
