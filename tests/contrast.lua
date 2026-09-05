-- WCAG contrast over every pair the theme renders, derived from the group tables.
local fail = 0

local function repo_root()
  local src = debug.getinfo(1, "S").source
  src = src:gsub("^@", "")
  return vim.fn.fnamemodify(vim.fn.fnamemodify(src, ":p:h"), ":h")
end

local root = repo_root()
vim.cmd("cd " .. vim.fn.fnameescape(root))
package.path = root .. "/?.lua;" .. root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua;" .. package.path

local wcag = require("tests.lib.wcag")
local context = require("tests.pairs")
local pairs_map = context.surfaces

-- A group's surface: its own entry first, then its family's window, unless it
-- is one of the groups that carries a plugin prefix but draws over the buffer.
local function surface_of(name)
  if pairs_map[name] then
    return pairs_map[name]
  end
  if context.on_normal[name] then
    return nil
  end
  for _, fam in ipairs(context.families) do
    if name:sub(1, #fam.prefix) == fam.prefix and name ~= fam.surface then
      return fam.surface
    end
  end
  return nil
end

local lain = require("lain")
lain.setup()
local config = lain.config
local palette = require("lain.palette")

local gok, groups = pcall(require("lain.groups").highlight_groups, config)
if not gok then
  print("FAIL  highlight_groups errored: " .. tostring(groups))
  fail = fail + 1
  groups = {}
end

local overrides = {
  Conceal = { floor = 2.0, reason = "decoration tier: not information-bearing" },
  ["@conceal"] = { floor = 2.0, reason = "decoration tier: not information-bearing" },
  EndOfBuffer = { floor = 2.0, reason = "decoration tier: not information-bearing" },
  FlashBackdrop = { floor = 2.0, reason = "decoration tier: not information-bearing" },
  Ignore = { floor = 2.0, reason = "decoration tier: not information-bearing" },
  NonText = { floor = 2.0, reason = "decoration tier: not information-bearing" },
  SpecialKey = { floor = 2.0, reason = "decoration tier: not information-bearing" },
  Whitespace = { floor = 2.0, reason = "decoration tier: not information-bearing" },
  CratesNvimPopupPillBorder = { floor = 3.0, reason = "non-text chrome" },
  FloatBorder = { floor = 3.0, reason = "non-text chrome" },
  FoldColumn = { floor = 3.0, reason = "non-text chrome" },
  LineNr = { floor = 3.0, reason = "non-text chrome" },
  OutlineGuides = { floor = 3.0, reason = "non-text chrome" },
  SignColumn = { floor = 3.0, reason = "non-text chrome" },
  WinSeparator = { floor = 3.0, reason = "non-text chrome" },
  SpellBad = { floor = 3.0, reason = "spell undercurl sp colour, non-text" },
  SpellCap = { floor = 3.0, reason = "spell undercurl sp colour, non-text" },
  SpellLocal = { floor = 3.0, reason = "spell undercurl sp colour, non-text" },
  SpellRare = { floor = 3.0, reason = "spell undercurl sp colour, non-text" },
}

local function sorted_keys(t)
  local ks = {}
  for k in pairs(t) do
    ks[#ks + 1] = k
  end
  table.sort(ks)
  return ks
end

local function is_colour(v)
  return type(v) == "string" and v ~= "" and v ~= "NONE"
end

local function effective_bg(name)
  local seen = {}
  local function resolve(n)
    if seen[n] then
      return nil
    end
    seen[n] = true
    local g = groups[n]
    if g then
      if is_colour(g.bg) then
        return g.bg
      end
      if is_colour(g.link) then
        local via = resolve(g.link)
        if via then
          return via
        end
      end
    end
    local surface = surface_of(n)
    if surface then
      local via = resolve(surface)
      if via then
        return via
      end
    end
    return nil
  end
  local bg = resolve(name)
  if bg then
    return bg
  end
  local normal = groups.Normal
  if normal and is_colour(normal.bg) then
    return normal.bg
  end
  return nil
end

local function check(label, fg, bg, floor, reason)
  local rounded = tonumber(wcag.format(wcag.ratio(fg, bg)))
  local suffix = reason and ("  " .. reason) or ""
  if rounded >= floor then
    print(("ok    %-34s %s on %s  %5s%s"):format(label, fg, bg, wcag.format(wcag.ratio(fg, bg)), suffix))
  else
    print(
      ("FAIL  %-34s %s on %s  %5s < %s%s"):format(
        label,
        fg,
        bg,
        wcag.format(wcag.ratio(fg, bg)),
        tostring(floor),
        suffix
      )
    )
    fail = fail + 1
  end
end

print("-- rendered pairs")
for _, name in ipairs(sorted_keys(groups)) do
  local g = groups[name]
  if type(g) == "table" then
    local colour = nil
    if is_colour(g.fg) then
      colour = g.fg
    elseif is_colour(g.sp) then
      colour = g.sp
    end
    if colour then
      local ov = overrides[name]
      local floor = ov and ov.floor or 4.5
      local bg = effective_bg(name)
      if bg then
        check(name, colour, bg, floor, ov and ov.reason)
      else
        print(("FAIL  %s: background cannot be resolved"):format(name))
        fail = fail + 1
      end
    end
  end
end

local function module_group_map(modname)
  local mok, mod = pcall(require, modname)
  if not mok or type(mod) ~= "table" then
    return nil
  end
  local function is_map(t)
    if type(t) ~= "table" then
      return false
    end
    local first = next(t)
    return first ~= nil and type(t[first]) == "table"
  end
  if is_map(mod) then
    return mod
  end
  if is_map(mod.groups) then
    return mod.groups
  end
  if type(mod.highlight_groups) == "function" then
    local hok, map = pcall(mod.highlight_groups, config)
    if hok and is_map(map) then
      return map
    end
  end
  return nil
end

print("")
print("-- cursor-line pairs, 4.5:1 floor")
print("note: groups with their own background or a lower floor are asserted in the rendered pairs section")
local syn_names = {}
local syn_map = module_group_map("lain.groups.syntax")
local ts_map = module_group_map("lain.groups.treesitter")
local function add_names(map)
  for name in pairs(map) do
    syn_names[name] = true
  end
end
if syn_map then
  add_names(syn_map)
else
  print("note: lain.groups.syntax is not introspectable; cursor-line check covers @ captures only")
end
if ts_map then
  add_names(ts_map)
end
for name in pairs(groups) do
  if name:match("^@") then
    syn_names[name] = true
  end
end
-- One list, two grounds. A syntax group added later has to clear both, and
-- deriving the names once is what makes that automatic rather than remembered.
local syn_fg = {}
for _, name in ipairs(sorted_keys(syn_names)) do
  local g = groups[name] or (syn_map and syn_map[name]) or (ts_map and ts_map[name])
  if g and is_colour(g.fg) and not is_colour(g.bg) and not overrides[name] then
    syn_fg[#syn_fg + 1] = { name, g.fg }
  end
end

for _, pair in ipairs(syn_fg) do
  check(pair[1], pair[2], palette.ui.bg_surface, 4.5, nil)
end

print("")
print("-- tint-mode Visual pairs, 3.0:1 floor")
-- bg_hover is lighter than the cursor-line ground, so clearing 4.5:1 above says
-- nothing about this one. Under styles.visual = "tint" the selection keeps the
-- syntax colours and only swaps the ground, and 3.0:1 is the floor a transient
-- selection is held to rather than the 4.5:1 body-text one.
for _, pair in ipairs(syn_fg) do
  check(pair[1], pair[2], palette.ui.bg_hover, 3.0, "tint-mode Visual exemption")
end
print(("      %d syntax groups over both grounds"):format(#syn_fg))

print("")
print("-- lualine theme pairs, 4.5:1 floor")
local ltheme = nil
local lok, lres = pcall(require, "lualine.themes.lain")
if lok and type(lres) == "table" then
  ltheme = lres
end
if not ltheme then
  print("note: lualine theme absent; lualine pair measurement deferred to integration")
else
  for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
    local m = ltheme[mode]
    if type(m) ~= "table" then
      print(("FAIL  lualine section %s is missing"):format(mode))
      fail = fail + 1
    else
      for _, seg in ipairs({ "a", "b", "c" }) do
        local s = m[seg]
        local label = "lualine." .. mode .. "." .. seg
        if type(s) ~= "table" then
          print(("FAIL  %s is missing"):format(label))
          fail = fail + 1
        elseif is_colour(s.fg) and is_colour(s.bg) then
          check(label, s.fg, s.bg, 4.5, nil)
        else
          print(("FAIL  %s lacks an fg/bg pair"):format(label))
          fail = fail + 1
        end
      end
    end
  end
end

io.stdout:flush()
if fail > 0 then
  print("")
  print("contrast check failed")
  io.stdout:flush()
  vim.cmd("cquit!")
else
  print("")
  print("all pairs pass")
  io.stdout:flush()
end
