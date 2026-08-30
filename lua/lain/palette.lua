-- Semantic tokens. Nothing downstream names a colour directly.
local ramp = require("lain.ramp")

local ui = {
  bg = ramp.back_1,
  bg_surface = ramp.back_2,
  bg_hover = ramp.back_3,
  bg_fill = ramp.high_1,
  fg_on_fill = ramp.back_1,
  fg = ramp.high_1,
  fg_chrome = ramp.fore_1,
  fg_dim = ramp.high_4,
  fg_muted = ramp.back_9,
  rule = ramp.high_6,
  decoration = ramp.back_5,
  border = ramp.fore_4,
  border_focus = ramp.fore_1,
  accent = ramp.accent,
  alert = ramp.error_bg,
  alert_fg = ramp.success_fg,
}

local syn = {
  text = ramp.high_1,
  type = ramp.high_2,
  string = ramp.high_3,
  punct = ramp.high_4,
  comment = ramp.back_9,
  keyword = ramp.fore_1,
  preproc = ramp.fore_2,
  fun = ramp.success_fg,
  special = ramp.accent,
}

local diag = {
  error = ramp.accent,
  warn = ramp.fore_1,
  info = ramp.high_3,
  hint = ramp.back_9,
  ok = ramp.success_fg,
  warn_fill = ramp.warning_bg,
  ok_fill = ramp.success_bg,
}

local diff = {
  add = ramp.high_11,
  change = ramp.back_3,
  delete = ramp.fore_10,
  text = ramp.high_9,
}

return {
  ui = ui,
  syn = syn,
  diag = diag,
  diff = diff,
}
