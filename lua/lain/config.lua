-- Configuration defaults and validation.
local M = {}

-- Border styles lain will set 'winborder' to. Rounded is absent on purpose and
-- refused by name below: lain draws square corners.
local borders = {
  ["none"] = true,
  ["single"] = true,
  ["double"] = true,
  ["solid"] = true,
}

M.defaults = {
  styles = {
    visual = "fill",
  },
  border = "single",
  terminal_colors = true,
  transparent = false,
  on_highlights = nil,
}

function M.resolve(opts)
  local o = opts or {}
  local merged = {
    styles = {
      visual = (o.styles and o.styles.visual) or M.defaults.styles.visual,
    },
    border = o.border,
    terminal_colors = o.terminal_colors,
    transparent = o.transparent,
    on_highlights = o.on_highlights,
  }
  if merged.border == nil then
    merged.border = M.defaults.border
  end
  if merged.terminal_colors == nil then
    merged.terminal_colors = M.defaults.terminal_colors
  end
  if merged.transparent == nil then
    merged.transparent = M.defaults.transparent
  end
  if merged.styles.visual ~= "fill" and merged.styles.visual ~= "tint" then
    error("lain: styles.visual must be \"fill\" or \"tint\"")
  end
  if merged.border == "rounded" then
    error("lain: border has no \"rounded\"; lain draws square corners")
  end
  if merged.border ~= false and not borders[merged.border] then
    error("lain: border must be false, \"none\", \"single\", \"double\" or \"solid\"")
  end
  if type(merged.terminal_colors) ~= "boolean" then
    error("lain: terminal_colors must be a boolean")
  end
  if type(merged.transparent) ~= "boolean" then
    error("lain: transparent must be a boolean")
  end
  if merged.on_highlights ~= nil and type(merged.on_highlights) ~= "function" then
    error("lain: on_highlights must be a function")
  end
  return merged
end

return M
