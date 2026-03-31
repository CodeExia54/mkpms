#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get install -y \
  build-essential \
  cmake \
  gcc-aarch64-linux-gnu \
  binutils-aarch64-linux-gnu \
  make \
  git

echo "[ok] Ubuntu build environment ready."
echo "[next] Run: ./scripts/build_wxshadow.sh"
