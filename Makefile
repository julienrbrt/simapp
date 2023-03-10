#!/usr/bin/make -f

PWD=$(shell pwd)

update-next:
	@cd app; \
	$(PWD)/scripts/update.sh main next

update-v047:
	@cd app; \
	$(PWD)/scripts/update.sh release/v0.47.x v047

build:
	@cd app/$(version); \
	$(PWD)/scripts/build.sh $(version)

init:
	$(PWD)/scripts/init.sh $(version)

faucet:
	@cd faucet && npm install;

.PHONY: update-next update-v047 build init faucet