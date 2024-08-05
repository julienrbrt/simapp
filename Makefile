#!/usr/bin/make -f

PWD=$(shell pwd)

update-next-v2:
	$(PWD)/scripts/update-v2.sh main $(PWD)/app/next-v2

update-next:
	$(PWD)/scripts/update.sh main $(PWD)/app/next

update-v052-v2:
	$(PWD)/scripts/update-v2.sh release/v0.52.x $(PWD)/app/v052-v2 cosmossdk.io/runtime/v2 cosmossdk.io/server/v2 cosmossdk.io/store/v2 cosmossdk.io/server/v2/stf cosmossdk.io/server/v2/appmanager cosmossdk.io/api cosmossdk.io/store cosmossdk.io/core cosmossdk.io/core/testing

update-v052:
	$(PWD)/scripts/update.sh release/v0.52.x $(PWD)/app/v052

update-v050:
	$(PWD)/scripts/update.sh release/v0.50.x $(PWD)/app/v050

update-v047:
	$(PWD)/scripts/update.sh release/v0.47.x $(PWD)/app/v047

build:
	@cd app/$(version); \
	$(PWD)/scripts/build.sh $(version)

init:
	$(PWD)/scripts/init.sh $(version)

run:
	@cd app/$(version); \
	./simapp-$(version) start --home ./.simapp

faucet:
	@cd faucet && npm install;

.PHONY: update-next update-v052 update-v050 update-v047 build init faucet