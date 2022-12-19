#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Expected init.sh <app version>"
    exit 1
fi

# load env
if [ -f ".env" ]; then
    source .env
fi

# set variables
SIMD_BIN=./app/$1/simapp-$1
SIMD_HOME=./app/$1/.simapp
CHAIN_ID=$1-1

GENESIS=$SIMD_HOME/config/genesis.json
APP_CONFIG=$SIMD_HOME/config/app.toml

# check if app exists
if [ ! -f "$SIMD_BIN" ]; then
    echo "App $SIMD_BIN does not exist. Please build it first."
    exit 1
fi

# configure simapp
rm -rf $SIMD_HOME || true
$SIMD_BIN config chain-id $CHAIN_ID --home $SIMD_HOME
$SIMD_BIN config keyring-backend test --home $SIMD_HOME
# add keys
if [[ -z $ROOT_MNEMONIC ]]; then
    $SIMD_BIN keys add root --home $SIMD_HOME
else
  echo $ROOT_MNEMONIC | $SIMD_BIN keys add root --recover --home $SIMD_HOME
fi
if [[ -z $FAUCET_MNEMONIC ]]; then
  $SIMD_BIN keys add faucet --home $SIMD_HOME
else
  echo $FAUCET_MNEMONIC | $SIMD_BIN keys add faucet --recover --home $SIMD_HOME
fi
# init chain
$SIMD_BIN init $1 --chain-id $CHAIN_ID --default-denom stake --home $SIMD_HOME
# update genesis
$SIMD_BIN genesis add-genesis-account root 100000000000000000stake --keyring-backend test --home $SIMD_HOME
$SIMD_BIN genesis add-genesis-account faucet 1000000000000000stake --keyring-backend test --home $SIMD_HOME
# create default validator
$SIMD_BIN genesis gentx root 10000000000000000stake --chain-id $CHAIN_ID --home $SIMD_HOME
$SIMD_BIN genesis collect-gentxs --home $SIMD_HOME

# install dasel
if ! command -v dasel &> /dev/null
then
    go install github.com/tomwright/dasel/cmd/dasel@272b38fee3a2
fi

# configure genesis
dasel put string -f $GENESIS '.app_state.gov.voting_params.voting_period' "3600s"

# configure node (TODO use confix after https://github.com/cosmos/cosmos-sdk/pull/14342)
dasel put bool -f $APP_CONFIG "telemetry.enabled" true
dasel put int -f $APP_CONFIG "telemetry.prometheus-retention-time" 60
dasel put bool -f $APP_CONFIG "api.enable" true
dasel put bool -f $APP_CONFIG "api.swagger" true
dasel put bool -f $APP_CONFIG "api.enabled-unsafe-cors" true
dasel put bool -f $APP_CONFIG "grpc-web.enabled-unsafe-cors" true