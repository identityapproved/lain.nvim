-- Terminal ANSI: the sixteen palette slots.
local ramp = require("lain.ramp")

local M = {}

local slots = {
  ramp.back_1,
  ramp.fore_1,
  ramp.high_4,
  ramp.success_fg,
  ramp.back_9,
  ramp.fore_2,
  ramp.high_3,
  ramp.back_12,
  ramp.back_8,
  ramp.accent,
  ramp.high_2,
  ramp.success_fg,
  ramp.back_10,
  ramp.fore_1,
  ramp.high_2,
  ramp.white_pure,
}

function M.apply()
  for i, hex in ipairs(slots) do
    vim.g["terminal_color_" .. (i - 1)] = hex:upper()
  end
end

return M
