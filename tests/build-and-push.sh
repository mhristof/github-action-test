#! /usr/bin/env bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

die() { echo "$*" 1>&2 ; exit 1; }
PORT=$(shuf -n 1 -i 49152-65535)
# shellcheck source=dev.sh
source tests/dev.sh "$PORT"

IMAGE="localhost:$PORT/image"

cat << EOF > Dockerfile
FROM alpine:latest
EOF

$BUILD "$IMAGE" "true" "latest" | tee out

docker pull "$IMAGE" || die "$0: Error, image $IMAGE not pushed to registry"
grep "name=image0::localhost:$PORT/image:latest" out &> /dev/null || die "$0: Error, output image is not set"

exit 0
