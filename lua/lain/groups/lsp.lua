-- LSP and diagnostic groups.
local p = require("lain.palette")

local M = {}

M.DiagnosticError = { fg = p.diag.error }
M.DiagnosticWarn = { fg = p.diag.warn }
M.DiagnosticInfo = { fg = p.diag.info }
M.DiagnosticHint = { fg = p.diag.hint }
M.DiagnosticOk = { fg = p.diag.ok }
M.DiagnosticUnnecessary = { fg = p.ui.fg_muted }
M.DiagnosticDeprecated = { fg = p.ui.fg_muted, strikethrough = true }

M.DiagnosticSignError = { fg = p.diag.error }
M.DiagnosticSignWarn = { fg = p.diag.warn }
M.DiagnosticSignInfo = { fg = p.diag.info }
M.DiagnosticSignHint = { fg = p.diag.hint }
M.DiagnosticSignOk = { fg = p.diag.ok }

M.DiagnosticUnderlineError = { sp = p.diag.error, undercurl = true }
M.DiagnosticUnderlineWarn = { sp = p.diag.warn, undercurl = true }
M.DiagnosticUnderlineInfo = { sp = p.diag.info, undercurl = true }
M.DiagnosticUnderlineHint = { sp = p.diag.hint, undercurl = true }
M.DiagnosticUnderlineOk = { sp = p.diag.ok, undercurl = true }

M.DiagnosticVirtualTextError = { fg = p.ui.alert_fg, bg = p.ui.alert }
M.DiagnosticVirtualTextWarn = { fg = p.ui.fg_on_fill, bg = p.diag.warn_fill }
M.DiagnosticVirtualTextInfo = { fg = p.diag.info }
M.DiagnosticVirtualTextHint = { fg = p.diag.hint }
M.DiagnosticVirtualTextOk = { fg = p.diag.ok, bg = p.diag.ok_fill }

M.DiagnosticVirtualLinesError = { link = "DiagnosticError" }
M.DiagnosticVirtualLinesWarn = { link = "DiagnosticWarn" }
M.DiagnosticVirtualLinesInfo = { link = "DiagnosticInfo" }
M.DiagnosticVirtualLinesHint = { link = "DiagnosticHint" }
M.DiagnosticVirtualLinesOk = { link = "DiagnosticOk" }

M.DiagnosticFloatingError = { fg = p.ui.alert_fg, bg = p.ui.alert }
M.DiagnosticFloatingWarn = { fg = p.ui.fg_on_fill, bg = p.diag.warn_fill }
M.DiagnosticFloatingInfo = { fg = p.diag.info, bg = p.ui.bg_surface }
M.DiagnosticFloatingHint = { fg = p.diag.hint, bg = p.ui.bg_surface }
M.DiagnosticFloatingOk = { fg = p.diag.ok, bg = p.diag.ok_fill }

M.LspCodeLens = { fg = p.ui.fg_dim }
M.LspCodeLensSeparator = { link = "LineNr" }
M.LspInlayHint = { fg = p.ui.fg_muted, bg = p.ui.bg_surface }
M.LspInfoBorder = { link = "FloatBorder" }
M.LspReferenceRead = { bg = p.ui.bg_hover }
M.LspReferenceTarget = { bg = p.ui.bg_hover }
M.LspReferenceText = { bg = p.ui.bg_hover }
M.LspReferenceWrite = { bg = p.ui.bg_hover }
M.LspSignatureActiveParameter = { bg = p.ui.bg_hover }

M["@lsp.type.class"] = { fg = p.syn.type }
M["@lsp.type.enum"] = { fg = p.syn.type }
M["@lsp.type.interface"] = { fg = p.syn.type }
M["@lsp.type.struct"] = { fg = p.syn.type }
M["@lsp.type.type"] = { fg = p.syn.type }
M["@lsp.type.typeParameter"] = { fg = p.syn.type }
M["@lsp.type.enumMember"] = { fg = p.syn.type }
M["@lsp.type.constant"] = { fg = p.syn.type }
M["@lsp.type.event"] = { fg = p.syn.type }
M["@lsp.type.parameter"] = { fg = p.syn.string }
M["@lsp.type.property"] = { fg = p.syn.text }
M["@lsp.type.function"] = { fg = p.syn.fun }
M["@lsp.type.method"] = { fg = p.syn.fun }
M["@lsp.type.macro"] = { fg = p.syn.preproc }
M["@lsp.type.namespace"] = { fg = p.syn.preproc }
M["@lsp.type.variable"] = { fg = p.syn.text }
M["@lsp.type.modifier"] = { fg = p.syn.keyword }
M["@lsp.type.string"] = { fg = p.syn.string }
M["@lsp.type.number"] = { fg = p.syn.type }
M["@lsp.type.boolean"] = { fg = p.syn.type }
M["@lsp.type.regexp"] = { fg = p.syn.special }
M["@lsp.type.decorator"] = { fg = p.syn.text }
M["@lsp.type.label"] = { link = "Label" }

M["@lsp.type.comment"] = {}
M["@lsp.type.keyword"] = {}
M["@lsp.type.operator"] = {}

M["@lsp.mod.readonly"] = { fg = p.syn.text }
M["@lsp.mod.deprecated"] = { strikethrough = true }

M["@lsp.typemod.function.builtin"] = { link = "@function.builtin" }
M["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" }
M["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" }
M["@lsp.typemod.variable.global"] = { fg = p.syn.text }
M["@lsp.typemod.variable.defaultLibrary"] = { fg = p.syn.text }

return M
