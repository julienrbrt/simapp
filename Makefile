#!/usr/bin/make -f

export FILTER_BRANCH_SQUELCH_WARNING=1

all: update-next build-next update-v047 build-v047

update-next:
	@cd app; \
	rm -rf next; \
	git clone --depth 1 https://github.com/cosmos/cosmos-sdk next; \
	cd next; \
	git filter-branch --subdirectory-filter simapp; \
	rm -rf .git

build-next:
	@cd app/next; \
	go build -o simapp-next

update-v047:
	@cd app; \
	rm -rf v047; \
	git clone -b release/v0.47.x --depth 1 https://github.com/cosmos/cosmos-sdk v047; \
	cd v047; \
	git filter-branch --subdirectory-filter simapp; \
	rm -rf .git

build-v047:
	@cd app/v047; \
	go build -o simapp-v047

.PHONY: update-next build-next update-v047 build-v047