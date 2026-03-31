#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${BUILD_DIR:-${ROOT_DIR}/build}"
CC_BIN="${CC:-aarch64-linux-gnu-gcc}"

# KernelPatch framework lives in git submodule .kp.
if [[ ! -d "${ROOT_DIR}/.kp/kernel" ]]; then
  if command -v git >/dev/null 2>&1; then
    echo "[info] .kp/kernel missing, initializing submodules..."
    git -C "${ROOT_DIR}" submodule update --init --recursive
  fi
fi

if [[ ! -d "${ROOT_DIR}/.kp/kernel" ]]; then
  echo "[error] Missing .kp/kernel. Run: git submodule update --init --recursive" >&2
  exit 1
fi

cmake -S "${ROOT_DIR}" -B "${BUILD_DIR}" -DCMAKE_C_COMPILER="${CC_BIN}" -DCMAKE_BUILD_TYPE=Release
cmake --build "${BUILD_DIR}" --target wxshadow.kpm wxshadow_client -j"$(nproc)"

echo "[ok] Built:"
echo "  ${BUILD_DIR}/kpms/wxshadow/wxshadow.kpm"
echo "  ${BUILD_DIR}/kpms/wxshadow/wxshadow_client"
