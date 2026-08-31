#!/usr/bin/env sh
# Golden-file snapshot of lain's own highlight groups.

set -eu

cd "$(dirname "$0")/.."
GOLDEN="tests/golden/highlights.txt"
UPDATE="${1:-}"

fail=0
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT INT TERM

cat >"$tmp/emit.lua" <<'EOF'
local ok, err = pcall(function()
  local config = require("lain.config").resolve({})
  local groups = require("lain.groups").highlight_groups(config)

  local names = {}
  for name in pairs(groups) do
    names[#names + 1] = name
  end
  table.sort(names)

  local styles = { "bold", "italic", "reverse", "standout", "strikethrough", "undercurl", "underline" }

  local function hex(n)
    if type(n) ~= "number" then
      return ""
    end
    return string.format("%06X", n)
  end

  local out = {}
  for _, name in ipairs(names) do
    local spec = groups[name]
    if type(spec) ~= "table" then
      out[#out + 1] = name .. " badspec"
    elseif spec.link then
      out[#out + 1] = name .. " -> " .. spec.link
    elseif next(spec) == nil then
      out[#out + 1] = name .. " clear"
    else
      vim.api.nvim_set_hl(0, name, spec)
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      local parts = { name }
      if hl.fg then
        parts[#parts + 1] = "fg=" .. hex(hl.fg)
      end
      if hl.bg then
        parts[#parts + 1] = "bg=" .. hex(hl.bg)
      end
      if hl.sp then
        parts[#parts + 1] = "sp=" .. hex(hl.sp)
      end
      for _, s in ipairs(styles) do
        if hl[s] then
          parts[#parts + 1] = s
        end
      end
      out[#out + 1] = table.concat(parts, " ")
    end
  end

  io.stdout:write(table.concat(out, "\n") .. "\n")
  io.stdout:flush()
end)
if not ok then
  io.stderr:write(tostring(err) .. "\n")
  vim.cmd("cquit!")
end
EOF

if XDG_CONFIG_HOME="$tmp/config" XDG_DATA_HOME="$tmp/data" \
  XDG_STATE_HOME="$tmp/state" XDG_CACHE_HOME="$tmp/cache" \
  nvim --clean --headless -i NONE --cmd "set rtp+=$PWD" \
  -c "luafile $tmp/emit.lua" -c "qa!" >"$tmp/got" 2>"$tmp/err"; then
  status=0
else
  status=$?
fi

if [ "$status" -eq 0 ]; then
  printf 'ok    nvim exited 0\n'
else
  printf 'FAIL  nvim exited %s\n' "$status"
  fail=1
fi

if [ -s "$tmp/err" ]; then
  printf 'FAIL  stderr not empty:\n'
  sed 's/^/      /' "$tmp/err"
  fail=1
else
  printf 'ok    stderr empty\n'
fi

if [ "$UPDATE" = "--update" ]; then
  if [ "$fail" -ne 0 ]; then
    echo
    echo "snapshots differ"
    exit 1
  fi
  mkdir -p "$(dirname "$GOLDEN")"
  cp "$tmp/got" "$GOLDEN"
  printf 'updated  %s (%s lines)\n' "$GOLDEN" "$(wc -l <"$tmp/got")"
  echo
  echo "snapshots written"
  exit 0
fi

if [ "$fail" -eq 0 ]; then
  if [ ! -f "$GOLDEN" ]; then
    printf 'FAIL  %s is missing; run tests/snapshot.sh --update\n' "$GOLDEN"
    fail=1
  elif diff "$GOLDEN" "$tmp/got" >"$tmp/diff" 2>&1; then
    printf 'ok    %s (%s lines)\n' "$GOLDEN" "$(wc -l <"$tmp/got")"
  else
    printf 'FAIL  %s differs; first divergences:\n' "$GOLDEN"
    sed 's/^/      /' "$tmp/diff" | head -n 20
    fail=1
  fi
fi

if [ "$fail" -ne 0 ]; then
  echo
  echo "snapshots differ"
  exit 1
fi
echo
echo "snapshots match"
