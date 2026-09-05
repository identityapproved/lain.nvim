#!/usr/bin/env sh
# Static checks: stylua, luacheck, byte-compile, shell tools.

set -eu

cd "$(dirname "$0")/.."
fail=0

# CI sets LINT_STRICT=1 so an absent tool fails instead of quietly skipping.
# Skipping is right on a dev box that lacks one; it is how luacheck went unrun
# in CI for as long as it did.
strict="${LINT_STRICT:-0}"

unavailable() {
  if [ "$strict" = "1" ]; then
    printf 'FAIL  %s %s\n' "$1" "$2"
    fail=1
  else
    printf 'skip  %s %s\n' "$1" "$2"
  fi
}

files="$(git ls-files '*.lua' 2>/dev/null)"
if [ -z "$files" ]; then
  files="$(find . -type f -name '*.lua' -not -path './.git/*' -not -path './.omo/*' | sed 's|^\./||' | sort)"
fi
if [ -z "$files" ]; then
  echo "FAIL  no lua files found"
  exit 1
fi

if command -v stylua >/dev/null 2>&1; then
  # shellcheck disable=SC2086
  for f in $files; do
    if stylua --check "$f"; then
      printf 'ok    stylua %s\n' "$f"
    else
      printf 'FAIL  stylua %s\n' "$f"
      fail=1
    fi
  done
else
  unavailable stylua "not installed"
fi

if ! command -v luacheck >/dev/null 2>&1; then
  unavailable luacheck "not installed"
elif ! luacheck --version >/dev/null 2>&1; then
  # A luacheck whose shebang picks an interpreter that cannot see its modules
  # is on PATH and still useless. Say which, rather than failing as if the
  # sources were at fault.
  unavailable luacheck "on PATH but not runnable: interpreter cannot load its modules"
else
  # Flags live in .luacheckrc, picked up from the repo root.
  # shellcheck disable=SC2086
  if luacheck $files; then
    echo "ok    luacheck"
  else
    fail=1
  fi
fi

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT INT TERM
cat >"$tmp" <<'EOF'
-- Byte-compile check: loadfile each path, never execute.
local fail = 0
for i = 1, select("#", ...) do
  local path = select(i, ...)
  local f, err = loadfile(path)
  if f then
    print("ok    compiles " .. path)
  else
    print("FAIL  " .. path .. ": " .. tostring(err))
    fail = fail + 1
  end
end
io.stdout:flush()
if fail > 0 then
  vim.cmd("cquit!")
end
EOF
# shellcheck disable=SC2086
if nvim -l "$tmp" $files; then
  echo "ok    byte-compile (nvim -l)"
else
  fail=1
fi

for f in tests/*.sh; do
  if sh -n "$f"; then
    printf 'ok    sh -n %s\n' "$f"
  else
    printf 'FAIL  sh -n %s\n' "$f"
    fail=1
  fi
done

if command -v shellcheck >/dev/null 2>&1; then
  if shellcheck tests/*.sh; then
    echo "ok    shellcheck"
  else
    fail=1
  fi
else
  unavailable shellcheck "not installed"
fi

if command -v shfmt >/dev/null 2>&1; then
  if shfmt -d -ln posix -i 2 tests/*.sh; then
    echo "ok    shfmt"
  else
    echo "FAIL  shfmt: run shfmt -w -ln posix -i 2 tests/*.sh"
    fail=1
  fi
else
  unavailable shfmt "not installed"
fi

[ "$fail" -eq 0 ] || {
  echo
  echo "lint failed"
  exit 1
}
echo
echo "lint passed"
