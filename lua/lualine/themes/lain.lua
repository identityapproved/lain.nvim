-- Lualine theme for lain: rose chrome and dim ochre on the surface ground, mode fills carrying black text.
local p = require("lain.palette")

return {
  normal = {
    a = { fg = p.ui.fg_on_fill, bg = p.ui.fg_chrome, gui = "bold" },
    b = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface },
    c = { fg = p.ui.fg, bg = p.ui.bg_surface },
  },
  insert = {
    a = { fg = p.ui.fg_on_fill, bg = p.syn.fun, gui = "bold" },
    b = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface },
    c = { fg = p.ui.fg, bg = p.ui.bg_surface },
  },
  visual = {
    a = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill, gui = "bold" },
    b = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface },
    c = { fg = p.ui.fg, bg = p.ui.bg_surface },
  },
  replace = {
    a = { fg = p.ui.alert_fg, bg = p.ui.alert, gui = "bold" },
    b = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface },
    c = { fg = p.ui.fg, bg = p.ui.bg_surface },
  },
  command = {
    a = { fg = p.ui.fg_on_fill, bg = p.ui.accent, gui = "bold" },
    b = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface },
    c = { fg = p.ui.fg, bg = p.ui.bg_surface },
  },
  inactive = {
    a = { fg = p.ui.fg_dim, bg = p.ui.bg_surface, gui = "bold" },
    b = { fg = p.ui.fg_dim, bg = p.ui.bg_surface },
    c = { fg = p.ui.fg_dim, bg = p.ui.bg_surface },
  },
}
