#!/usr/bin/env sh
# Every check, cheapest failure first.

set -eu

cd "$(dirname "$0")"

./lint.sh
echo
nvim -l palette.lua
echo
nvim -l contrast.lua
echo
./smoke.sh
echo
./hooks.sh
echo
./health.sh
echo
./snapshot.sh
