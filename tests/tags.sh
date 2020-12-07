#! /usr/bin/env bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

PORT=$(shuf -n 1 -i 49152-65535)
# shellcheck source=dev.sh
source tests/dev.sh "$PORT"

IMAGE="localhost:$PORT/image"

cat << EOF > Dockerfile
FROM alpine:latest
EOF

$BUILD "$IMAGE" "tag1,tag2"

docker pull "$IMAGE:tag1" || die "$0: Error, image $IMAGE:tag1 not pushed to registry"
docker pull "$IMAGE:tag2" || die "$0: Error, image $IMAGE:tag2 not pushed to registry"

exit 0
