#!/bin/bash

UID = $(shell id -u)
DOCKER_BE = mvc-app

help: ## Show this help message
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

start: ## Start the containers
	docker network create mvc || true
	U_ID=${UID} docker-compose up -d

stop: ## Stop the containers
	U_ID=${UID} docker-compose stop

restart: ## Restart the containers
	$(MAKE) stop && $(MAKE) start

build: ## Rebuilds all the containers
	docker network create mvc || true
	U_ID=${UID} docker-compose build

ssh: ## bash into the be container
	U_ID=${UID} docker exec -it --user appuser ${DOCKER_BE} bash