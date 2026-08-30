#!/usr/bin/env sh
# Every check, cheapest failure first.

set -eu

cd "$(dirname "$0")"

nvim -l palette.lua
echo
nvim -l contrast.lua
echo
./smoke.sh
