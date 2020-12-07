#! /usr/bin/env bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'


export ROOT=$(git rev-parse --show-toplevel)
export BUILD=$ROOT/build-and-push.sh 

function finish {
    echo "Cleaning up $REGISTRY_ID"
    docker rm -f $REGISTRY_ID
}
trap finish EXIT

REGISTRY_ID=$(docker run -d -p ${1}:5000 --rm registry:2)

BASE=$(basename "$0")
workspace=$(mktemp --directory --tmpdir "$BASE-XXXXXXXX")
cd "$workspace"
