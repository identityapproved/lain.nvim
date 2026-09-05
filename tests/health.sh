#!/usr/bin/env sh
# :checkhealth lain in a throwaway XDG root: no ERROR, and no WARNING once the
# environment advertises truecolor.

set -eu

cd "$(dirname "$0")/.."

fail=0
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT INT TERM

if XDG_CONFIG_HOME="$tmp/config" XDG_DATA_HOME="$tmp/data" \
  XDG_STATE_HOME="$tmp/state" XDG_CACHE_HOME="$tmp/cache" \
  COLORTERM=truecolor \
  nvim --clean --headless -i NONE --cmd "set rtp+=$PWD" \
  -c "colorscheme lain" -c "checkhealth lain" \
  -c "write! $tmp/report" -c "qa!" >"$tmp/out" 2>"$tmp/err"; then
  status=0
else
  status=$?
fi

if [ "$status" -eq 0 ]; then
  printf 'ok    nvim exited 0\n'
else
  printf 'FAIL  nvim exited %s\n' "$status"
  sed 's/^/      /' "$tmp/err"
  fail=1
fi

if [ ! -s "$tmp/report" ]; then
  printf 'FAIL  checkhealth produced no report\n'
  fail=1
else
  # Every section the module starts must appear, so a silently dropped check
  # cannot pass as a clean run.
  for section in "Neovim version" "Truecolor" "Colorscheme" "Configuration"; do
    if grep -qF "$section" "$tmp/report"; then
      printf 'ok    section %s\n' "$section"
    else
      printf 'FAIL  section %s missing\n' "$section"
      fail=1
    fi
  done

  if grep -q "ERROR" "$tmp/report"; then
    printf 'FAIL  report contains an ERROR:\n'
    grep -n "ERROR" "$tmp/report" | sed 's/^/      /'
    fail=1
  else
    printf 'ok    no ERROR lines\n'
  fi

  if grep -q "WARNING" "$tmp/report"; then
    printf 'FAIL  report contains a WARNING:\n'
    grep -n "WARNING" "$tmp/report" | sed 's/^/      /'
    fail=1
  else
    printf 'ok    no WARNING lines\n'
  fi
fi

if [ "$fail" -ne 0 ]; then
  echo
  echo "health check failed"
  exit 1
fi
echo
echo "health check passed"
