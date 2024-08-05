#!/bin/bash
# update-v2 is an updated version of update.sh that is used to update the simapp to the latest version of the cosmos-sdk.
# it takes a list of go.mod names that it updates from the main branch instead of the latest commit from the release branch

if [ $# -lt 2 ]; then
    echo "Usage: clone.sh <branch> <target-directory> [<go_mod_name1> <go_mod_name2> ...]"
    exit 1
fi

branch=$1
target_dir=$2
shift 2
go_mod_names=("$@")

# remove previous simapp
rm -rf $target_dir

# clone cosmos-sdk
export FILTER_BRANCH_SQUELCH_WARNING=1
git clone -b $branch --depth 1 https://github.com/cosmos/cosmos-sdk $target_dir
cd $target_dir

# save last commit
COMMIT=$(git rev-parse HEAD)
echo $COMMIT > ./COMMIT

# keep only simapp v2
git filter-branch --subdirectory-filter simapp/v2
rm -rf .git

# get cosmos-sdk latest commit
latest_commit=$(git ls-remote https://github.com/cosmos/cosmos-sdk.git refs/heads/main | cut -f1 || "main")

# bump all cosmos-sdk packages to latest branch commit
VERSIONS=$(go mod edit -json | jq -r '.Replace[].Old.Path')

# Initialize variables for different types of replaces
BRANCH_REPLACES=""
MAIN_REPLACES=""
REQUIRES=""

for version in $VERSIONS; do
   if [[ " ${go_mod_names[@]} " =~ " ${version} " ]]; then
    MAIN_REPLACES+=" -replace $version=$version@$latest_commit"
    continue
  elif [[ $version == "github.com/cosmos/cosmos-sdk"* || $version == "cosmossdk.io/"* ]]; then
    BRANCH_REPLACES+=" -replace $version=$version@$COMMIT"
  fi
done

for mod in ${go_mod_names[@]}; do
  REQUIRES+=" -require $mod@$latest_commit"
done

# Apply the replaces
go mod edit $BRANCH_REPLACES $MAIN_REPLACES $REQUIRES


go mod tidy

# if error while updating revert folder
retVal=$?
if [ $retVal -ne 0 ]; then
  cd ../..
  git restore -s@ -SW  -- $target_dir
fi
exit $retVal