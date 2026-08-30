-- Canonical treesitter captures.
local p = require("lain.palette")

local M = {}

M["@variable"] = { fg = p.syn.text }
M["@variable.builtin"] = { fg = p.syn.text }
M["@variable.member"] = { fg = p.syn.text }
M["@variable.parameter"] = { fg = p.syn.string }
M["@variable.parameter.builtin"] = { fg = p.syn.string }

M["@constant"] = { fg = p.syn.type }
M["@constant.builtin"] = { fg = p.syn.type }
M["@constant.macro"] = { fg = p.syn.type }

M["@module"] = { fg = p.syn.preproc }
M["@module.builtin"] = { fg = p.syn.preproc }
M["@label"] = { link = "Label" }

M["@string"] = { fg = p.syn.string }
M["@string.documentation"] = { fg = p.syn.string }
M["@string.escape"] = { fg = p.syn.special }
M["@string.regexp"] = { fg = p.syn.special }
M["@string.special"] = { fg = p.syn.special }
M["@string.special.symbol"] = { fg = p.syn.special }
M["@string.special.path"] = { fg = p.syn.special }
M["@string.special.url"] = { fg = p.syn.special }

M["@character"] = { fg = p.syn.string }
M["@character.special"] = { fg = p.syn.special }

M["@boolean"] = { fg = p.syn.type }
M["@number"] = { fg = p.syn.type }
M["@number.float"] = { fg = p.syn.type }

M["@type"] = { fg = p.syn.type }
M["@type.builtin"] = { fg = p.syn.type }
M["@type.definition"] = { fg = p.syn.type }
M["@type.qualifier"] = { fg = p.syn.type }

M["@attribute"] = { fg = p.syn.text }
M["@attribute.builtin"] = { fg = p.syn.text }
M["@property"] = { fg = p.syn.text }

M["@function"] = { fg = p.syn.fun }
M["@function.builtin"] = { fg = p.syn.fun }
M["@function.call"] = { fg = p.syn.fun }
M["@function.method"] = { fg = p.syn.fun }
M["@function.method.call"] = { fg = p.syn.fun }
M["@function.macro"] = { fg = p.syn.preproc }
M["@constructor"] = { fg = p.syn.fun }

M["@operator"] = { fg = p.syn.punct }

M["@keyword"] = { fg = p.syn.keyword }
M["@keyword.conditional"] = { fg = p.syn.keyword }
M["@keyword.conditional.ternary"] = { fg = p.syn.keyword }
M["@keyword.coroutine"] = { fg = p.syn.keyword }
M["@keyword.repeat"] = { fg = p.syn.keyword }
M["@keyword.return"] = { fg = p.syn.keyword }
M["@keyword.function"] = { fg = p.syn.keyword }
M["@keyword.operator"] = { fg = p.syn.keyword }
M["@keyword.modifier"] = { fg = p.syn.keyword }
M["@keyword.type"] = { fg = p.syn.keyword }
M["@keyword.exception"] = { fg = p.syn.keyword }
M["@keyword.debug"] = { fg = p.syn.keyword }
M["@keyword.import"] = { fg = p.syn.preproc }
M["@keyword.directive"] = { fg = p.syn.preproc }
M["@keyword.directive.define"] = { fg = p.syn.preproc }

M["@punctuation.delimiter"] = { fg = p.syn.punct }
M["@punctuation.bracket"] = { fg = p.syn.punct }
M["@punctuation.special"] = { fg = p.syn.punct }

M["@comment"] = { fg = p.syn.comment, italic = true }
M["@comment.documentation"] = { fg = p.syn.comment, italic = true }
M["@comment.error"] = { fg = p.ui.accent }
M["@comment.warning"] = { fg = p.syn.comment, italic = true }
M["@comment.note"] = { fg = p.syn.comment, italic = true }
M["@comment.todo"] = { fg = p.syn.comment, italic = true }

M["@markup.strong"] = { fg = p.syn.special }
M["@markup.italic"] = { fg = p.syn.text, italic = true }
M["@markup.strikethrough"] = { strikethrough = true }
M["@markup.underline"] = { underline = true }
M["@markup.heading"] = { fg = p.ui.fg_chrome, bold = true }
M["@markup.heading.1"] = { link = "@markup.heading" }
M["@markup.heading.2"] = { link = "@markup.heading" }
M["@markup.heading.3"] = { link = "@markup.heading" }
M["@markup.heading.4"] = { link = "@markup.heading" }
M["@markup.heading.5"] = { link = "@markup.heading" }
M["@markup.heading.6"] = { link = "@markup.heading" }
M["@markup.quote"] = { fg = p.ui.fg_dim }
M["@markup.math"] = { fg = p.syn.string }
M["@markup.link"] = { fg = p.syn.special }
M["@markup.link.label"] = { fg = p.syn.special }
M["@markup.link.url"] = { fg = p.syn.string, underline = true }
M["@markup.raw"] = { fg = p.syn.keyword }
M["@markup.raw.block"] = { fg = p.syn.text }
M["@markup.list"] = { fg = p.syn.punct }
M["@markup.list.checked"] = { fg = p.syn.text }
M["@markup.list.unchecked"] = { fg = p.syn.text }

M["@tag"] = { fg = p.syn.text }
M["@tag.builtin"] = { fg = p.syn.text }
M["@tag.attribute"] = { fg = p.syn.text }
M["@tag.delimiter"] = { fg = p.syn.punct }

M["@none"] = {}
M["@conceal"] = { fg = p.ui.decoration }

return M
