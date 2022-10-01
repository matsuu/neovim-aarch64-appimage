#!/bin/sh

set -e

BRANCH="master"
if [ $# -ne 0 ]; then
  BRANCH="$1"
fi
TAG="build-neovim:${BRANCH}"
BINARY="nvim-${BRANCH}.appimage"

docker image build --build-arg BRANCH="${BRANCH}" -t "${TAG}" .
docker run --rm "${TAG}" cat /nvim.appimage > "${BINARY}"
chmod +x "${BINARY}"
docker image rm "${TAG}"
