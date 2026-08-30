-- Editor chrome groups.
local p = require("lain.palette")

local M = {}

M.ColorColumn = { bg = p.ui.bg_hover }
M.Conceal = { fg = p.ui.decoration }
M.CurSearch = { fg = p.ui.fg_on_fill, bg = p.ui.accent }
M.Cursor = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.CursorColumn = { bg = p.ui.bg_surface }
M.CursorIM = { link = "Cursor" }
M.CursorLine = { bg = p.ui.bg_surface }
M.CursorLineFold = { link = "CursorLine" }
M.CursorLineNr = { fg = p.ui.fg_chrome, bold = true }
M.CursorLineSign = { link = "CursorLine" }
M.Directory = { fg = p.ui.fg_chrome }
M.EndOfBuffer = { fg = p.ui.decoration }
M.ErrorMsg = { fg = p.ui.alert_fg, bg = p.ui.alert }
M.FloatBorder = { fg = p.ui.border }
M.FloatFooter = { fg = p.ui.fg_dim, bg = p.ui.bg_surface }
M.FloatShadow = { bg = p.ui.bg }
M.FloatShadowThrough = { bg = p.ui.bg }
M.FloatTitle = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface, bold = true }
M.FoldColumn = { fg = p.ui.rule }
M.Folded = { fg = p.ui.fg_dim, bg = p.ui.bg_surface }
M.HealthError = { fg = p.ui.alert_fg, bg = p.ui.alert }
M.HealthSuccess = { fg = p.diag.ok, bg = p.diag.ok_fill }
M.HealthWarning = { fg = p.ui.fg_on_fill, bg = p.diag.warn_fill }
M.IncSearch = { fg = p.ui.fg_on_fill, bg = p.ui.accent }
M.LineNr = { fg = p.ui.rule }
M.LineNrAbove = { link = "LineNr" }
M.LineNrBelow = { link = "LineNr" }
M.MatchParen = { fg = p.ui.accent, bold = true }
M.ModeMsg = { fg = p.ui.fg_chrome, bold = true }
M.MoreMsg = { fg = p.ui.fg_chrome }
M.MsgArea = { fg = p.ui.fg_dim }
M.MsgSeparator = { bg = p.ui.bg_hover }
M.NonText = { fg = p.ui.decoration }
M.Normal = { fg = p.ui.fg, bg = p.ui.bg }
M.NormalFloat = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.NormalNC = { link = "Normal" }
M.Pmenu = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.PmenuExtra = { fg = p.ui.fg_dim, bg = p.ui.bg_surface }
M.PmenuExtraSel = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.PmenuKind = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface }
M.PmenuKindSel = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.PmenuMatch = { bold = true }
M.PmenuMatchSel = { bold = true }
M.PmenuSbar = { bg = p.ui.bg_hover }
M.PmenuSel = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.PmenuThumb = { bg = p.ui.bg_fill }
M.Question = { fg = p.ui.accent }
M.QuickFixLine = { bg = p.ui.bg_hover }
M.Search = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.SignColumn = { fg = p.ui.rule }
M.SpecialKey = { fg = p.ui.decoration }
M.SpellBad = { undercurl = true, sp = p.diag.error }
M.SpellCap = { undercurl = true, sp = p.diag.warn }
M.SpellLocal = { undercurl = true, sp = p.diag.hint }
M.SpellRare = { undercurl = true, sp = p.diag.info }
M.StatusLine = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface }
M.StatusLineNC = { fg = p.ui.fg_dim, bg = p.ui.bg_surface }
M.StatusLineTerm = { link = "StatusLine" }
M.StatusLineTermNC = { link = "StatusLineNC" }
M.Substitute = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.TabLine = { fg = p.ui.fg_dim, bg = p.ui.bg_surface }
M.TabLineFill = { bg = p.ui.bg_surface }
M.TabLineSel = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.TermCursor = { link = "Cursor" }
M.TermCursorNC = { link = "TermCursor" }
M.Title = { fg = p.ui.fg_chrome, bold = true }
M.VertSplit = { link = "WinSeparator" }
M.WarningMsg = { fg = p.ui.fg_on_fill, bg = p.diag.warn_fill }
M.Whitespace = { fg = p.ui.decoration }
M.WildMenu = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.WinBar = { fg = p.ui.fg_chrome }
M.WinBarNC = { fg = p.ui.fg_dim }
M.WinSeparator = { fg = p.ui.rule }
M.debugBreakpoint = { fg = p.ui.accent }
M.debugPC = { bg = p.ui.bg_hover }
M.lCursor = { link = "Cursor" }

return M
