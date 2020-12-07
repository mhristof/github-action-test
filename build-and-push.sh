#! /usr/bin/env bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

usage() {
    cat << EOF
Build and push a docker image to a repository.

Usage:
    ./$0 IMAGE_URL

EOF
}

die() {
    echo "$*" 1>&2;
    usage
    exit 1;
}
IMAGE_URL=${1:-}

if [[ -z $IMAGE_URL ]]; then
    die "Error, image url is not defined"
fi

echo "docker push $IMAGE_URL"
exit 0
