#!/usr/bin/make -f

update-all: update-next update-v047

update-next:
	@cd app; \
	rm -rf next; \
	../scripts/clone-simapp.sh main next

update-v047:
	@cd app; \
	rm -rf v047; \
	../scripts/clone-simapp.sh release/v0.47.x v047

init:
	./scripts/init.sh $(version)

faucet:
	@cd faucet && npm install;

.PHONY: update-next update-v047 init faucet