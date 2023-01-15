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

# bump cosmos-sdk version to latest branch commit
go mod edit -replace github.com/cosmos/cosmos-sdk=github.com/cosmos/cosmos-sdk@$COMMIT
go mod tidy

# if error while updating revert folder
retVal=$?
if [ $retVal -ne 0 ]; then
  cd ../..
  git restore -s@ -SW  -- ./app/$2
fi
exit $retVal