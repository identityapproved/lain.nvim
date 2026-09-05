-- Group merge: editor, syntax, treesitter, lsp, diff and plugins modules, with the Visual variant applied.
local p = require("lain.palette")

local M = {}

local modules = {
  "lain.groups.editor",
  "lain.groups.syntax",
  "lain.groups.treesitter",
  "lain.groups.lsp",
  "lain.groups.diff",
  "lain.groups.plugins",
}

-- Groups that paint the window ground. Under transparent the terminal supplies
-- it instead. FloatShadow keeps its black: a shadow falling on the wallpaper is
-- the whole point of a shadow.
local ground = {
  "DapUINormal",
  "MasonBackdrop",
  "Normal",
  "TroubleNormal",
}

-- Module tables are require-cached and shared, so a variant copies before it
-- edits. Mutating in place would leak into the next call.
local function without_bg(spec)
  local copy = {}
  for k, v in pairs(spec) do
    copy[k] = v
  end
  copy.bg = "NONE"
  return copy
end

M.highlight_groups = function(config)
  local groups = {}
  for _, name in ipairs(modules) do
    local mod = require(name)
    for group, spec in pairs(mod) do
      groups[group] = spec
    end
  end
  local visual = "fill"
  if config and config.styles and config.styles.visual then
    visual = config.styles.visual
  end
  if visual == "tint" then
    groups.Visual = { bg = p.ui.bg_hover }
  else
    groups.Visual = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
  end
  groups.VisualNOS = { link = "Visual" }
  if config and config.transparent then
    for _, name in ipairs(ground) do
      if groups[name] then
        groups[name] = without_bg(groups[name])
      end
    end
  end
  return groups
end

return M
