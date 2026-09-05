#!/usr/bin/env sh
# Headless load in a throwaway XDG root: entry contract, ANSI slots, core highlights.

set -eu

cd "$(dirname "$0")/.."

fail=0
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT INT TERM

cat >"$tmp/assert.lua" <<'EOF'
local fail = 0

local function say(msg)
  io.stdout:write(msg .. "\n")
end

local function check(cond, okmsg, failmsg)
  if cond then
    say("ok    " .. okmsg)
  else
    say("FAIL  " .. failmsg)
    fail = fail + 1
  end
end

local function hex(n)
  if type(n) ~= "number" then
    return tostring(n)
  end
  return string.format("%06X", n)
end

vim.cmd.colorscheme("lain")
say("ok    colorscheme lain reloaded")

say("-- entry contract")
check(vim.g.colors_name == "lain", "colors_name lain", "colors_name is " .. tostring(vim.g.colors_name))
check(vim.o.termguicolors == true, "termguicolors on", "termguicolors off")
check(vim.o.background == "dark", "background dark", "background is " .. tostring(vim.o.background))

say("-- messages")
local bad = nil
for line in vim.fn.execute("messages"):gmatch("[^\n]+") do
  if line:match("E%d+") then
    bad = line
  end
end
check(bad == nil, "messages free of E-lines", "messages contains an E-line: " .. tostring(bad))

say("-- ANSI slots")
for i = 0, 15 do
  local v = vim.g["terminal_color_" .. i]
  check(type(v) == "string" and v ~= "", "terminal_color_" .. i .. " = " .. tostring(v), "terminal_color_" .. i .. " is empty")
end

say("-- core highlights")
local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
check(hex(normal.bg) == "000000", "Normal bg 000000", "Normal bg is " .. hex(normal.bg))
check(hex(normal.fg) == "C1B48E", "Normal fg C1B48E", "Normal fg is " .. hex(normal.fg))
local cursorline = vim.api.nvim_get_hl(0, { name = "CursorLine" })
check(hex(cursorline.bg) == "1A1A1A", "CursorLine bg 1A1A1A", "CursorLine bg is " .. hex(cursorline.bg))
local visual = vim.api.nvim_get_hl(0, { name = "Visual" })
check(hex(visual.bg) == "C1B48E", "Visual bg C1B48E", "Visual bg is " .. hex(visual.bg))
check(hex(visual.fg) == "000000", "Visual fg 000000", "Visual fg is " .. hex(visual.fg))

say("-- nothing renders outside the ramp")
-- Every group nvim knows about, resolved through its links to the colours that
-- actually land on screen. A group lain never names keeps nvim's default, and
-- nvim's defaults are not in the lain palette - OkMsg shipped a mint green into
-- a theme with no green that way. This is the check that catches the next one.
local ramp = require("lain.ramp")
local known = {}
for _, hexval in pairs(ramp) do
  known[tonumber(hexval:sub(2), 16)] = true
end

-- Exempt, and only these: the vimscript expression-parser groups, which are
-- hardcoded red-on-red markers for malformed expressions, and the 'redrawdebug'
-- overlay. Neither is reachable in ordinary editing, and neither takes a
-- colorscheme's colours if it were.
local function exempt(name)
  return name:match("^Nvim") ~= nil or name:match("^RedrawDebug") ~= nil
end

local outside = {}
for name in pairs(vim.api.nvim_get_hl(0, {})) do
  if not exempt(name) then
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    for _, key in ipairs({ "fg", "bg", "sp" }) do
      if type(hl[key]) == "number" and not known[hl[key]] then
        outside[#outside + 1] = name .. " " .. key .. "=#" .. hex(hl[key])
      end
    end
  end
end
table.sort(outside)
check(#outside == 0, "every rendered colour is a ramp step", "outside the ramp: " .. table.concat(outside, ", "))

say("-- transparent")
-- Reload through the real entry point, the way a user setting the option would.
require("lain").setup({ transparent = true })
vim.cmd.colorscheme("lain")
local tnormal = vim.api.nvim_get_hl(0, { name = "Normal" })
check(tnormal.bg == nil, "Normal has no bg", "Normal bg is " .. hex(tnormal.bg))
check(hex(tnormal.fg) == "C1B48E", "Normal fg still C1B48E", "Normal fg is " .. hex(tnormal.fg))
local tfloat = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
check(hex(tfloat.bg) == "1A1A1A", "NormalFloat keeps its ground", "NormalFloat bg is " .. hex(tfloat.bg))
local tshadow = vim.api.nvim_get_hl(0, { name = "FloatShadow" })
check(hex(tshadow.bg) == "000000", "FloatShadow keeps its black", "FloatShadow bg is " .. hex(tshadow.bg))

-- Back to the default, and the ground must return: the variant may not leak
-- into the shared module tables.
require("lain").setup({})
vim.cmd.colorscheme("lain")
local restored = vim.api.nvim_get_hl(0, { name = "Normal" })
check(hex(restored.bg) == "000000", "Normal bg restored to 000000", "Normal bg is " .. hex(restored.bg))

if fail > 0 then
  io.stdout:flush()
  vim.cmd("cquit!")
else
  io.stdout:flush()
  vim.cmd("quit!")
end
EOF

if XDG_CONFIG_HOME="$tmp/config" XDG_DATA_HOME="$tmp/data" \
  XDG_STATE_HOME="$tmp/state" XDG_CACHE_HOME="$tmp/cache" \
  nvim --clean --headless -i NONE --cmd "set rtp+=$PWD" \
  -c "colorscheme lain" -c "luafile $tmp/assert.lua" 2>"$tmp/err"; then
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

if [ "$fail" -ne 0 ]; then
  echo
  echo "smoke test failed"
  exit 1
fi
echo
echo "smoke test passed"
