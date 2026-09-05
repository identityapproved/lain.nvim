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

# A luacheck whose shebang picks an interpreter that cannot see its modules is on
# PATH and still useless. Distributions build it for one Lua slot and leave the
# #!/usr/bin/env lua shebang pointing at whatever `lua` happens to be, so the
# script is fine and only the interpreter in front of it is wrong. Name the slots
# rather than give up: an unrunnable luacheck used to read as a clean run.
luacheck_cmd=""
luacheck_why="not installed"
if command -v luacheck >/dev/null 2>&1; then
  luacheck_why="on PATH but no Lua on this box can load its modules"
  if luacheck --version >/dev/null 2>&1; then
    luacheck_cmd="luacheck"
  else
    luacheck_path="$(command -v luacheck)"
    for interp in lua5.1 lua5.2 lua5.3 lua5.4 luajit lua; do
      if command -v "$interp" >/dev/null 2>&1 &&
        "$interp" "$luacheck_path" --version >/dev/null 2>&1; then
        luacheck_cmd="$interp $luacheck_path"
        break
      fi
    done
  fi
fi

if [ -z "$luacheck_cmd" ]; then
  unavailable luacheck "$luacheck_why"
else
  # Flags live in .luacheckrc, picked up from the repo root.
  # shellcheck disable=SC2086
  if $luacheck_cmd $files; then
    if [ "$luacheck_cmd" = "luacheck" ]; then
      echo "ok    luacheck"
    else
      printf 'ok    luacheck (via %s)\n' "${luacheck_cmd%% *}"
    fi
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
