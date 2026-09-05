-- Option variants: what each option is allowed to change, and what it must not.
local fail = 0

local function repo_root()
  local src = debug.getinfo(1, "S").source
  src = src:gsub("^@", "")
  return vim.fn.fnamemodify(vim.fn.fnamemodify(src, ":p:h"), ":h")
end

local root = repo_root()
vim.cmd("cd " .. vim.fn.fnameescape(root))
package.path = root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua;" .. package.path

local p = require("lain.palette")
local config = require("lain.config")
local groups = require("lain.groups")

-- FloatShadow is a shadow cast on whatever is behind the window. Under
-- transparent that is the wallpaper, which is the whole point, so these two
-- keep the ground colour the others give up.
local shadows = {
  FloatShadow = true,
  FloatShadowThrough = true,
}

local function build(opts)
  return groups.highlight_groups(config.resolve(opts))
end

local function say(msg)
  print(msg)
end

local function check(cond, okmsg, failmsg)
  if cond then
    print("ok    " .. okmsg)
  else
    print("FAIL  " .. failmsg)
    fail = fail + 1
  end
end

local function sorted(set)
  local ks = {}
  for k in pairs(set) do
    ks[#ks + 1] = k
  end
  table.sort(ks)
  return ks
end

local function same_spec(a, b)
  if a == nil or b == nil then
    return a == b
  end
  for k, v in pairs(a) do
    if b[k] ~= v then
      return false
    end
  end
  for k, v in pairs(b) do
    if a[k] ~= v then
      return false
    end
  end
  return true
end

-- Names present in either table whose specs differ.
local function diff(a, b)
  local names = {}
  for n in pairs(a) do
    names[n] = true
  end
  for n in pairs(b) do
    names[n] = true
  end
  local out = {}
  for n in pairs(names) do
    if not same_spec(a[n], b[n]) then
      out[n] = true
    end
  end
  return out
end

local function list(set)
  local ks = sorted(set)
  if #ks == 0 then
    return "nothing"
  end
  return table.concat(ks, ", ")
end

local base = build({})

say("-- styles.visual changes the selection and nothing else")
local tint = build({ styles = { visual = "tint" } })
local visual_diff = diff(base, tint)
check(visual_diff.Visual == true, "Visual differs between fill and tint", "Visual is identical in both modes")
visual_diff.Visual = nil
check(
  next(visual_diff) == nil,
  "no other group moves with styles.visual",
  "styles.visual also moved: " .. list(visual_diff)
)
check(
  base.Visual.bg == p.ui.bg_fill and base.Visual.fg == p.ui.fg_on_fill,
  "fill is an ochre fill with black text",
  "fill Visual is " .. vim.inspect(base.Visual)
)
check(
  tint.Visual.bg == p.ui.bg_hover and tint.Visual.fg == nil,
  "tint is a ground swap with syntax intact",
  "tint Visual is " .. vim.inspect(tint.Visual)
)

say("")
say("-- transparent reaches every group that paints the window ground")
local clear = build({ transparent = true })
local ground = diff(base, clear)

-- The list of ground-painting groups in lain.groups lives there by hand. This
-- is the check that it stays complete: a plugin group added later that paints
-- ui.bg and is not on it would quietly stay opaque under transparent.
local paints_ground = {}
for name, spec in pairs(base) do
  if type(spec) == "table" and spec.bg == p.ui.bg then
    paints_ground[name] = true
  end
end

local missed = {}
for name in pairs(paints_ground) do
  if not ground[name] and not shadows[name] then
    missed[name] = true
  end
end
check(
  next(missed) == nil,
  "every ground-painting group is dropped or exempt",
  "still opaque under transparent: " .. list(missed)
)

local stray = {}
for name in pairs(ground) do
  if not paints_ground[name] then
    stray[name] = true
  end
end
check(
  next(stray) == nil,
  "transparent touches nothing that was not the ground",
  "transparent also moved: " .. list(stray)
)

for _, name in ipairs(sorted(ground)) do
  check(clear[name].bg == "NONE", name .. " gives up its bg", name .. " bg is " .. tostring(clear[name].bg))
  check(clear[name].fg == base[name].fg, name .. " keeps its fg", name .. " fg changed to " .. tostring(clear[name].fg))
end
for _, name in ipairs(sorted(shadows)) do
  if base[name] then
    check(
      clear[name].bg == p.ui.bg,
      name .. " keeps the ground to fall on",
      name .. " bg is " .. tostring(clear[name].bg)
    )
  end
end

say("")
say("-- the module tables are shared, so no variant may write through them")
local again = build({})
local leaked = diff(base, again)
check(
  next(leaked) == nil,
  "a default build after two variants is unchanged",
  "leaked into the next build: " .. list(leaked)
)

io.stdout:flush()
if fail > 0 then
  print("")
  print("variant checks failed")
  io.stdout:flush()
  vim.cmd("cquit!")
else
  print("")
  print("variant checks passed")
  io.stdout:flush()
end
