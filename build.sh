#!/bin/sh

set -e

docker image build -t neovim .
docker run --rm neovim cat build/bin/nvim.appimage > nvim.appimage
chmod +x nvim.appimage
docker image rm neovim
