-- Legacy syntax groups.
local p = require("lain.palette")

local M = {}

M.Comment = { fg = p.syn.comment, italic = true }
M.Constant = { fg = p.syn.type }
M.String = { fg = p.syn.string }
M.Character = { fg = p.syn.string }
M.Number = { fg = p.syn.type }
M.Boolean = { fg = p.syn.type }
M.Float = { fg = p.syn.type }
M.Identifier = { fg = p.syn.text }
M.Function = { fg = p.syn.fun }
M.Statement = { fg = p.syn.keyword }
M.Conditional = { link = "Statement" }
M.Repeat = { link = "Statement" }
M.Label = { link = "Statement" }
M.Keyword = { link = "Statement" }
M.Exception = { link = "Statement" }
M.Operator = { fg = p.syn.punct }
M.PreProc = { fg = p.syn.preproc }
M.Include = { link = "PreProc" }
M.Define = { link = "PreProc" }
M.Macro = { link = "PreProc" }
M.PreCondit = { link = "PreProc" }
M.Type = { fg = p.syn.type }
M.StorageClass = { link = "Type" }
M.Structure = { link = "Type" }
M.Typedef = { link = "Type" }
M.Special = { fg = p.syn.special }
M.SpecialChar = { link = "Special" }
M.Tag = { fg = p.syn.text }
M.Delimiter = { fg = p.syn.punct }
M.SpecialComment = { fg = p.syn.comment, italic = true }
M.Debug = { fg = p.syn.special }
M.Underlined = { fg = p.syn.text, underline = true }
M.Ignore = { fg = p.ui.decoration }
M.Error = { fg = p.ui.alert_fg, bg = p.ui.alert }
M.Todo = { fg = p.ui.fg_on_fill, bg = p.ui.accent }

return M
