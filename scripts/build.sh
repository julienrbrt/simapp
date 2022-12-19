#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Expected build.sh <app version>"
    exit 1
fi

# build simapp
go build -ldflags "-X github.com/cosmos/cosmos-sdk/version.Name=simd -X github.com/cosmos/cosmos-sdk/version.AppName=simd -X github.com/cosmos/cosmos-sdk/version.Version=$1 -X github.com/cosmos/cosmos-sdk/version.Commit=$(cat COMMIT)" -o simapp-$1 ./simd