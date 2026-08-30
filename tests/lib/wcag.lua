-- WCAG 2.x contrast math, pure Lua.
local M = {}

local function channel(hex, i)
  local c = tonumber(hex:sub(i, i + 1), 16) / 255
  if c <= 0.04045 then
    return c / 12.92
  end
  return ((c + 0.055) / 1.055) ^ 2.4
end

function M.luminance(hex)
  local h = hex:gsub("^#", "")
  return 0.2126 * channel(h, 1) + 0.7152 * channel(h, 3) + 0.0722 * channel(h, 5)
end

function M.ratio(fg, bg)
  local a, b = M.luminance(fg), M.luminance(bg)
  if a < b then
    a, b = b, a
  end
  return (a + 0.05) / (b + 0.05)
end

function M.format(r)
  return string.format("%.2f", r)
end

return M
