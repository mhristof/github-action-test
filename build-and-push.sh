#! /usr/bin/env bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

usage() {
    cat << EOF
Build and push a docker image to a repository.

Usage:
    $0 IMAGE_URL

EOF
}

die() {
    echo "$*" 1>&2;
    usage
    exit 1;
}
IMAGE_URL=${1:-}
TAGS=${2:-}

if [[ -z $IMAGE_URL ]]; then
    die "Error, image url is not defined"
fi

docker build -t "$IMAGE_URL" .

for tag in $(echo "$TAGS" | tr ',' "\n"); do
    docker tag "$IMAGE_URL" "$IMAGE_URL:$tag"
    docker push "$IMAGE_URL:$tag"
done

exit 0
