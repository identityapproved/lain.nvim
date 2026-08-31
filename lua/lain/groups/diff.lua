-- Diff, git commit and git sign groups.
local p = require("lain.palette")

local M = {}

M.DiffAdd = { bg = p.diff.add }
M.DiffChange = { bg = p.diff.change }
M.DiffDelete = { bg = p.diff.delete }
M.DiffText = { fg = p.syn.fun, bg = p.diff.text }

M.Added = { fg = p.syn.string }
M.Changed = { fg = p.ui.fg_chrome }
M.Removed = { fg = p.syn.preproc }

M.diffAdded = { fg = p.syn.string }
M.diffRemoved = { fg = p.syn.preproc }
M.diffChanged = { fg = p.ui.fg_chrome }
M.diffFile = { fg = p.ui.fg_chrome }
M.diffNewFile = { fg = p.ui.fg_chrome }
M.diffOldFile = { fg = p.ui.fg_chrome }
M.diffIndexLine = { link = "LineNr" }
M.diffLine = { link = "LineNr" }
M.diffSubname = { link = "LineNr" }
M.diffComment = { fg = p.syn.comment, italic = true }
M.diffBDiffer = { fg = p.ui.fg_dim }
M.diffDiffer = { fg = p.ui.fg_dim }
M.diffIdentical = { fg = p.ui.fg_dim }
M.diffIsA = { fg = p.ui.fg_dim }
M.diffNoEOL = { fg = p.ui.fg_dim }
M.diffOnly = { fg = p.ui.fg_dim }
M.diffCommon = { fg = p.ui.fg_dim }

M["@diff.plus"] = { fg = p.syn.string }
M["@diff.minus"] = { fg = p.syn.preproc }
M["@diff.delta"] = { fg = p.ui.fg_chrome }

M.gitcommitSummary = { fg = p.syn.text }
M.gitcommitHeader = { fg = p.ui.fg_chrome }
M.gitcommitBranch = { fg = p.syn.special }
M.gitcommitSelectedType = { fg = p.syn.string }
M.gitcommitSelectedFile = { fg = p.syn.string }
M.gitcommitDiscardedType = { fg = p.syn.preproc }
M.gitcommitDiscardedFile = { fg = p.syn.preproc }
M.gitcommitOverflow = { fg = p.ui.alert_fg, bg = p.ui.alert }

M.GitSignsAdd = { fg = p.syn.string }
M.GitSignsChange = { fg = p.ui.fg_chrome }
M.GitSignsDelete = { fg = p.syn.preproc }
M.GitSignsChangedelete = { link = "GitSignsChange" }
M.GitSignsTopdelete = { link = "GitSignsDelete" }
M.GitSignsUntracked = { fg = p.ui.fg_muted }
M.GitSignsCurrentLn = { bg = p.ui.bg_surface }
M.GitSignsCurrentLineBlame = { fg = p.ui.fg_muted }
M.GitSignsVirtLnum = { link = "LineNr" }
M.GitSignsAddPreview = { bg = p.diff.add }
M.GitSignsDeletePreview = { bg = p.diff.delete }

return M
