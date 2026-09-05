-- Configuration defaults and validation.
local M = {}

M.defaults = {
  styles = {
    visual = "fill",
  },
  terminal_colors = true,
  transparent = false,
}

function M.resolve(opts)
  local o = opts or {}
  local merged = {
    styles = {
      visual = (o.styles and o.styles.visual) or M.defaults.styles.visual,
    },
    terminal_colors = o.terminal_colors,
    transparent = o.transparent,
  }
  if merged.terminal_colors == nil then
    merged.terminal_colors = M.defaults.terminal_colors
  end
  if merged.transparent == nil then
    merged.transparent = M.defaults.transparent
  end
  if merged.styles.visual ~= "fill" and merged.styles.visual ~= "tint" then
    error("lain: styles.visual must be \"fill\" or \"tint\"")
  end
  if type(merged.terminal_colors) ~= "boolean" then
    error("lain: terminal_colors must be a boolean")
  end
  if type(merged.transparent) ~= "boolean" then
    error("lain: transparent must be a boolean")
  end
  return merged
end

return M
