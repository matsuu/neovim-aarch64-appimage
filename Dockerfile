FROM ubuntu:20.04 as build

ARG BRANCH=master
ENV DEBIAN_FRONTEND=noninteractive
ENV CMAKE_BUILD_TYPE=Release

RUN \
  apt update && \
  apt upgrade -y && \
  apt install -y automake cmake curl g++ gettext git libtool-bin make pkg-config unzip

RUN  git clone -b ${BRANCH} --single-branch --depth 1 https://github.com/neovim/neovim.git

WORKDIR neovim

ADD nvim-appimage-appimagetool.patch nvim-appimage-appimagetool.patch

RUN \
  patch -p1 <nvim-appimage-appimagetool.patch && \
  make CMAKE_BUILD_TYPE=Release appimage

FROM busybox

COPY --from=build /neovim/build/bin/nvim.appimage /nvim.appimage
