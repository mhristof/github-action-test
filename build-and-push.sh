#! /usr/bin/env bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

if [[ ${DEBUG:-} ]]; then
    set -x
fi

usage() {
    cat << EOF
Build and push a docker image to a repository.

Usage:
    $0 IMAGE_URL [TAG1,TAG2,...]

EOF
}

die() {
    echo "$*" 1>&2;
    usage
    exit 1;
}
IMAGE_URL=${1:-}
LOGIN=${2:-}
TAGS=${3:-latest}

if [[ -z $IMAGE_URL ]]; then
    die "Error, image url is not defined"
fi

docker build -t "$IMAGE_URL" .
eval $LOGIN

i=0
for tag in $(echo "$TAGS" | tr ',' "\n"); do
    if [[ $i -eq 2 ]]; then
        die "Error, this github action only suports up to 2 tags"
    fi
    docker tag "$IMAGE_URL" "$IMAGE_URL:$tag"
    docker push "$IMAGE_URL:$tag"
    echo "::set-output name=image$i::$IMAGE_URL:$tag"
    i=$((++i))
done

exit 0
