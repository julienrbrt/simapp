#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Expected clone.sh <branch> <target-directory>"
    exit 1
fi

# remove previous simapp
rm -rf $2

# clone cosmos-sdk
export FILTER_BRANCH_SQUELCH_WARNING=1
git clone -b $1 --depth 1 https://github.com/cosmos/cosmos-sdk $2
cd $2

# save last commit
COMMIT=$(git rev-parse HEAD)
echo $COMMIT > ./COMMIT

# keep only simapp
git filter-branch --subdirectory-filter simapp
rm -rf .git

# remove replace tag from go.mod
sed -i '/\/\/ Simapp always use the latest version of the cosmos-sdk/d' go.mod
sed -i '/github.com\/cosmos\/cosmos-sdk => ..\/./d' go.mod

# bump cosmos-sdk version to latest branch commit
go get -u github.com/cosmos/cosmos-sdk@$COMMIT