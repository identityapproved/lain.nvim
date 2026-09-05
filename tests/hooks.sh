#!/usr/bin/env sh
# The on_highlights escape hatch: what a hook can reach, and what a broken one costs.

set -eu

cd "$(dirname "$0")/.."

fail=0
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT INT TERM

# Each case is its own nvim: a hook that errors writes to stderr, so the runs
# that expect a clean stderr have to stay separated from the ones that do not.
# stdin comes from /dev/null because an error message parks even a headless nvim
# on a hit-enter prompt, and the cases here are the ones that emit those.
run() {
  name="$1"
  want_err="$2"
  if XDG_CONFIG_HOME="$tmp/config" XDG_DATA_HOME="$tmp/data" \
    XDG_STATE_HOME="$tmp/state" XDG_CACHE_HOME="$tmp/cache" \
    nvim --clean --headless -i NONE --cmd "set rtp+=$PWD" \
    -c "luafile $tmp/$name.lua" \
    </dev/null >"$tmp/$name.out" 2>"$tmp/$name.err"; then
    status=0
  else
    status=$?
  fi
  sed 's/^/      /' "$tmp/$name.out"
  if [ "$status" -eq 0 ]; then
    printf 'ok    %s: nvim exited 0\n' "$name"
  else
    printf 'FAIL  %s: nvim exited %s\n' "$name" "$status"
    fail=1
  fi
  if [ -z "$want_err" ]; then
    if [ -s "$tmp/$name.err" ]; then
      printf 'FAIL  %s: stderr not empty:\n' "$name"
      sed 's/^/      /' "$tmp/$name.err"
      fail=1
    else
      printf 'ok    %s: stderr empty\n' "$name"
    fi
  elif grep -q "$want_err" "$tmp/$name.err"; then
    printf 'ok    %s: stderr carries "%s"\n' "$name" "$want_err"
  else
    printf 'FAIL  %s: stderr lacks "%s":\n' "$name" "$want_err"
    sed 's/^/      /' "$tmp/$name.err"
    fail=1
  fi
  if grep -q '^FAIL' "$tmp/$name.out"; then
    fail=1
  fi
}

cat >"$tmp/prelude.lua" <<'EOF'
local fail = 0

function _G.say(msg)
  io.stdout:write(msg .. "\n")
end

function _G.check(cond, okmsg, failmsg)
  if cond then
    say("ok    " .. okmsg)
  else
    say("FAIL  " .. failmsg)
    fail = fail + 1
  end
end

function _G.hex(n)
  if type(n) ~= "number" then
    return tostring(n)
  end
  return string.format("%06X", n)
end

function _G.fg_of(group)
  return hex(vim.api.nvim_get_hl(0, { name = group }).fg)
end

function _G.bg_of(group)
  return hex(vim.api.nvim_get_hl(0, { name = group }).bg)
end

function _G.done()
  io.stdout:flush()
  if fail > 0 then
    vim.cmd("cquit!")
  end
  vim.cmd("quit!")
end
EOF

cat >"$tmp/reach.lua" <<'EOF'
dofile(vim.env.LAIN_PRELUDE)

say("-- what the hook reaches")
local seen = nil
require("lain").setup({
  transparent = true,
  on_highlights = function(groups, palette)
    seen = palette
    groups.Comment = { fg = palette.ui.accent, italic = true }
    groups.LainHookNew = { fg = palette.syn.string }
    -- The hook runs after the variants, so it can put the ground back.
    groups.Normal = { fg = palette.ui.fg, bg = palette.ui.bg_surface }
  end,
})
vim.cmd.colorscheme("lain")

check(seen ~= nil and type(seen.ui) == "table", "the hook is handed the palette", "palette argument is " .. type(seen))
check(type(seen.ui.accent) == "string" and type(seen.syn.comment) == "string", "the palette carries its tokens", "palette tokens are missing")
check(fg_of("Comment") == "FFB1C3", "Comment repainted by the hook", "Comment fg is " .. fg_of("Comment"))
check(vim.api.nvim_get_hl(0, { name = "Comment" }).italic == true, "Comment italic set by the hook", "Comment is not italic")
check(fg_of("LainHookNew") == "A49978", "a group the hook invented is set", "LainHookNew fg is " .. fg_of("LainHookNew"))
check(bg_of("Normal") == "1A1A1A", "the hook has the last word over transparent", "Normal bg is " .. bg_of("Normal"))
check(bg_of("CursorLine") == "1A1A1A", "groups the hook ignored are untouched", "CursorLine bg is " .. bg_of("CursorLine"))

-- The hook mutates the assembled table. That table is rebuilt per load, but the
-- module tables behind it are require-cached and shared: a write that reached
-- one of those would survive into the next load.
say("-- no leak into the next load")
require("lain").setup({})
vim.cmd.colorscheme("lain")
check(fg_of("Comment") == "8A8A8A", "Comment restored once the hook is gone", "Comment fg is " .. fg_of("Comment"))
check(bg_of("Normal") == "000000", "Normal ground restored", "Normal bg is " .. bg_of("Normal"))

say("-- validation")
local ok = pcall(require("lain").setup, { on_highlights = "nope" })
check(ok == false, "a non-function on_highlights is rejected", "a string on_highlights was accepted")
ok = pcall(require("lain").setup, { on_highlights = nil })
check(ok == true, "nil on_highlights is the default", "nil on_highlights was rejected")

done()
EOF

cat >"$tmp/throws.lua" <<'EOF'
dofile(vim.env.LAIN_PRELUDE)

say("-- a hook that throws")
require("lain").setup({
  on_highlights = function(groups)
    groups.Comment = { fg = groups.Normal.fg }
    error("hook blew up")
  end,
})
vim.cmd.colorscheme("lain")

-- The load reports and carries on. An error in someone's config is not a reason
-- to hand them an unstyled editor.
check(vim.g.colors_name == "lain", "the colorscheme still loaded", "colors_name is " .. tostring(vim.g.colors_name))
check(bg_of("Normal") == "000000", "Normal still painted", "Normal bg is " .. bg_of("Normal"))
check(fg_of("Comment") == "C1B48E", "writes made before the error stand", "Comment fg is " .. fg_of("Comment"))
check(type(vim.g.terminal_color_0) == "string", "terminal slots still written", "terminal_color_0 is unset")

done()
EOF

cat >"$tmp/badspec.lua" <<'EOF'
dofile(vim.env.LAIN_PRELUDE)

say("-- a hook that writes a spec nvim rejects")
require("lain").setup({
  on_highlights = function(groups)
    groups.LainHookBad = { fg = "rose, obviously" }
  end,
})
vim.cmd.colorscheme("lain")

-- One bad spec skips one group, not every group the loop had not reached yet.
check(vim.g.colors_name == "lain", "the colorscheme still loaded", "colors_name is " .. tostring(vim.g.colors_name))
check(bg_of("Normal") == "000000", "Normal still painted", "Normal bg is " .. bg_of("Normal"))
check(fg_of("Comment") == "8A8A8A", "Comment still painted", "Comment fg is " .. fg_of("Comment"))
local bad = vim.api.nvim_get_hl(0, { name = "LainHookBad" })
check(next(bad) == nil, "the bad group was left unset", "LainHookBad is " .. vim.inspect(bad))

done()
EOF

LAIN_PRELUDE="$tmp/prelude.lua"
export LAIN_PRELUDE

run reach ""
run throws "on_highlights failed: .*hook blew up"
run badspec "skipped bad highlight spec for LainHookBad"

if [ "$fail" -ne 0 ]; then
  echo
  echo "hook tests failed"
  exit 1
fi
echo
echo "hook tests passed"
