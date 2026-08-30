-- Group merge: editor, syntax and treesitter modules, with the Visual variant applied.
local p = require("lain.palette")

local M = {}

local modules = { "lain.groups.editor", "lain.groups.syntax", "lain.groups.treesitter" }

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
  return groups
end

return M
