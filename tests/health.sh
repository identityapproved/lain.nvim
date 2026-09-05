#!/usr/bin/env sh
# :checkhealth lain in a throwaway XDG root, across the environments that change
# its verdict. A health check that only ever runs in the passing case is not
# evidence of anything, so the truecolor warning gets asserted in both
# directions.

set -eu

cd "$(dirname "$0")/.."

fail=0
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT INT TERM

# The developer's own terminal must not reach the scenarios: an inherited TMUX
# or COLORTERM would turn the negative case into a silent pass.
unset TMUX COLORTERM

# run <name>: writes the report to $tmp/<name>, inheriting whatever environment
# the caller set for it.
run() {
  name="$1"
  if XDG_CONFIG_HOME="$tmp/config" XDG_DATA_HOME="$tmp/data" \
    XDG_STATE_HOME="$tmp/state" XDG_CACHE_HOME="$tmp/cache" \
    nvim --clean --headless -i NONE --cmd "set rtp+=$PWD" \
    -c "colorscheme lain" -c "checkhealth lain" \
    -c "write! $tmp/$name" -c "qa!" >"$tmp/$name.out" 2>"$tmp/$name.err"; then
    status=0
  else
    status=$?
  fi

  if [ "$status" -ne 0 ]; then
    printf 'FAIL  %s: nvim exited %s\n' "$name" "$status"
    sed 's/^/      /' "$tmp/$name.err"
    fail=1
  elif [ ! -s "$tmp/$name" ]; then
    printf 'FAIL  %s: no report written\n' "$name"
    fail=1
  else
    printf 'ok    %s: report written\n' "$name"
  fi
}

# matches <name> <pattern>: how many lines match, 0 when none do.
matches() {
  grep -c "$2" "$tmp/$1" 2>/dev/null || true
}

# want <name> <pattern> <count> <label>
want() {
  got="$(matches "$1" "$2")"
  if [ "$got" -eq "$3" ]; then
    printf 'ok    %s: %s\n' "$1" "$4"
  else
    printf 'FAIL  %s: %s (matched %s, want %s)\n' "$1" "$4" "$got" "$3"
    grep -n "$2" "$tmp/$1" | sed 's/^/      /' || true
    fail=1
  fi
}

# A terminal that says it is truecolor: everything clean.
COLORTERM=truecolor TERM=xterm-256color run truecolor
if [ -s "$tmp/truecolor" ]; then
  # Every section the module starts must appear, so a check that silently
  # stopped running cannot pass as a clean report.
  for section in "Neovim version" "Truecolor" "Colorscheme" "Configuration"; do
    want truecolor "^$section" 1 "section $section"
  done
  want truecolor "ERROR" 0 "no ERROR lines"
  want truecolor "WARNING" 0 "no WARNING lines"
fi

# A direct-color terminfo entry, with nothing in the environment.
TERM=xterm-direct run direct
if [ -s "$tmp/direct" ]; then
  want direct "ERROR" 0 "no ERROR lines"
  want direct "WARNING" 0 "no WARNING lines"
fi

# Nothing advertising 24-bit anywhere: the warning has to fire, and it has to be
# the only one.
TERM=xterm-256color run plain
if [ -s "$tmp/plain" ]; then
  want plain "ERROR" 0 "no ERROR lines"
  want plain "WARNING" 1 "one WARNING line"
  want plain "no 24-bit signal" 1 "the warning is the truecolor one"
fi

if [ "$fail" -ne 0 ]; then
  echo
  echo "health check failed"
  exit 1
fi
echo
echo "health check passed"
