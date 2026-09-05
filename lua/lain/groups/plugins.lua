-- Plugin UI groups.
local p = require("lain.palette")

local M = {}

M.BlinkCmpDoc = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.BlinkCmpDocBorder = { link = "FloatBorder" }
M.BlinkCmpGhostText = { fg = p.ui.fg_muted }
M.BlinkCmpKind = { fg = p.ui.fg_chrome }
M.BlinkCmpKindClass = { fg = p.syn.type }
M.BlinkCmpKindConstant = { fg = p.syn.type }
M.BlinkCmpKindConstructor = { fg = p.syn.fun }
M.BlinkCmpKindEnum = { fg = p.syn.type }
M.BlinkCmpKindEnumMember = { fg = p.syn.type }
M.BlinkCmpKindField = { fg = p.syn.text }
M.BlinkCmpKindFunction = { fg = p.syn.fun }
M.BlinkCmpKindInterface = { fg = p.syn.type }
M.BlinkCmpKindKeyword = { fg = p.syn.keyword }
M.BlinkCmpKindMethod = { fg = p.syn.fun }
M.BlinkCmpKindModule = { fg = p.syn.preproc }
M.BlinkCmpKindProperty = { fg = p.syn.text }
M.BlinkCmpKindReference = { fg = p.syn.preproc }
M.BlinkCmpKindSnippet = { fg = p.syn.special }
M.BlinkCmpKindStruct = { fg = p.syn.type }
M.BlinkCmpKindTypeParameter = { fg = p.syn.type }
M.BlinkCmpKindValue = { fg = p.syn.text }
M.BlinkCmpKindVariable = { fg = p.syn.text }
M.BlinkCmpLabel = { fg = p.ui.fg }
M.BlinkCmpLabelDeprecated = { fg = p.ui.fg_muted, strikethrough = true }
M.BlinkCmpLabelDescription = { fg = p.ui.fg_dim }
M.BlinkCmpLabelDetail = { fg = p.ui.fg_dim }
M.BlinkCmpLabelMatch = { fg = p.ui.accent, bold = true }
M.BlinkCmpMenu = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.BlinkCmpMenuBorder = { link = "FloatBorder" }
M.BlinkCmpMenuSelection = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BlinkCmpSource = { fg = p.ui.fg_dim }

M.BufferLineBackground = { fg = p.ui.fg_dim, bg = p.ui.bg_surface }
M.BufferLineBuffer = { fg = p.ui.fg_dim, bg = p.ui.bg_surface }
M.BufferLineBufferSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineBufferVisible = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.BufferLineCloseButton = { fg = p.ui.fg_muted, bg = p.ui.bg_surface }
M.BufferLineCloseButtonSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineCloseButtonVisible = { fg = p.ui.fg_muted, bg = p.ui.bg_surface }
M.BufferLineDiagnostic = { fg = p.diag.warn, bg = p.ui.bg_surface }
M.BufferLineDiagnosticSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineDiagnosticVisible = { fg = p.diag.warn, bg = p.ui.bg_surface }
M.BufferLineError = { fg = p.diag.error, bg = p.ui.bg_surface }
M.BufferLineErrorDiagnostic = { fg = p.diag.error, bg = p.ui.bg_surface }
M.BufferLineErrorDiagnosticSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineErrorDiagnosticVisible = { fg = p.diag.error, bg = p.ui.bg_surface }
M.BufferLineErrorSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineErrorVisible = { fg = p.diag.error, bg = p.ui.bg_surface }
M.BufferLineFill = { bg = p.ui.bg_surface }
M.BufferLineGroupLabel = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineGroupSeparator = { link = "WinSeparator" }
M.BufferLineHint = { fg = p.diag.hint, bg = p.ui.bg_surface }
M.BufferLineHintDiagnostic = { fg = p.diag.hint, bg = p.ui.bg_surface }
M.BufferLineHintDiagnosticSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineHintDiagnosticVisible = { fg = p.diag.hint, bg = p.ui.bg_surface }
M.BufferLineHintSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineHintVisible = { fg = p.diag.hint, bg = p.ui.bg_surface }
M.BufferLineIndicatorSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineIndicatorVisible = { fg = p.ui.fg_muted, bg = p.ui.bg_surface }
M.BufferLineInfo = { fg = p.diag.info, bg = p.ui.bg_surface }
M.BufferLineInfoDiagnostic = { fg = p.diag.info, bg = p.ui.bg_surface }
M.BufferLineInfoDiagnosticSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineInfoDiagnosticVisible = { fg = p.diag.info, bg = p.ui.bg_surface }
M.BufferLineInfoSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineInfoVisible = { fg = p.diag.info, bg = p.ui.bg_surface }
M.BufferLineModified = { fg = p.diag.warn, bg = p.ui.bg_surface }
M.BufferLineModifiedSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineModifiedVisible = { fg = p.diag.warn, bg = p.ui.bg_surface }
M.BufferLineOffsetSeparator = { link = "WinSeparator" }
M.BufferLineSeparator = { link = "WinSeparator" }
M.BufferLineSeparatorSelected = { link = "WinSeparator" }
M.BufferLineSeparatorVisible = { link = "WinSeparator" }
M.BufferLineTab = { fg = p.ui.fg_dim, bg = p.ui.bg_surface }
M.BufferLineTabClose = { fg = p.ui.fg_muted, bg = p.ui.bg_surface }
M.BufferLineTabSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineTabSeparator = { link = "WinSeparator" }
M.BufferLineTabSeparatorSelected = { link = "WinSeparator" }
M.BufferLineWarning = { fg = p.diag.warn, bg = p.ui.bg_surface }
M.BufferLineWarningDiagnostic = { fg = p.diag.warn, bg = p.ui.bg_surface }
M.BufferLineWarningDiagnosticSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineWarningDiagnosticVisible = { fg = p.diag.warn, bg = p.ui.bg_surface }
M.BufferLineWarningSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.BufferLineWarningVisible = { fg = p.diag.warn, bg = p.ui.bg_surface }

-- crates.nvim links most of its groups to core ones, which lain already owns.
-- These four ship hardcoded hex that survives any colorscheme, so they are the
-- only ones worth restating.
M.CratesNvimPopupEnabled = { fg = p.diag.ok }
M.CratesNvimPopupPillBorder = { fg = p.ui.border }
M.CratesNvimPopupPillText = { fg = p.ui.fg, bg = p.ui.bg_hover }
M.CratesNvimPopupTransitive = { fg = p.syn.preproc }

-- nvim-dap ships no highlights; these are the sign group names its docs use.
M.DapBreakpoint = { fg = p.diag.error }
M.DapBreakpointCondition = { fg = p.diag.warn }
M.DapBreakpointRejected = { fg = p.ui.fg_muted }
M.DapLogPoint = { fg = p.diag.info }
M.DapStopped = { fg = p.diag.warn }
M.DapStoppedLine = { bg = p.ui.bg_hover }
M.DapUIBreakpointsCurrentLine = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.DapUIBreakpointsDisabledLine = { fg = p.ui.fg_muted }
M.DapUIBreakpointsInfo = { fg = p.syn.string }
M.DapUIBreakpointsLine = { link = "LineNr" }
M.DapUIBreakpointsPath = { fg = p.ui.fg_muted }
M.DapUICurrentFrameName = { fg = p.ui.accent, bold = true }
M.DapUILineNumber = { link = "LineNr" }
M.DapUIModifiedValue = { fg = p.diag.warn }
M.DapUINormal = { fg = p.ui.fg, bg = p.ui.bg }
M.DapUIPlayPause = { fg = p.diag.ok }
M.DapUIScope = { fg = p.ui.fg_chrome }
M.DapUIStop = { fg = p.diag.error }
M.DapUIStoppedThread = { fg = p.diag.warn }
M.DapUIThread = { fg = p.syn.string }
M.DapUIType = { fg = p.syn.type }
M.DapUIValue = { fg = p.syn.text }
M.DapUIVariable = { fg = p.syn.text }
M.NvimDapVirtualText = { fg = p.ui.fg_muted }
M.NvimDapVirtualTextChanged = { fg = p.diag.warn }
M.NvimDapVirtualTextError = { fg = p.diag.error }
M.NvimDapVirtualTextInfo = { fg = p.diag.info }

M.DashboardDesc = { fg = p.ui.fg }
M.DashboardFiles = { fg = p.ui.fg_chrome }
M.DashboardFooter = { fg = p.ui.fg_muted }
M.DashboardHeader = { fg = p.ui.fg_chrome }
M.DashboardIcon = { fg = p.ui.accent }
M.DashboardKey = { fg = p.ui.accent }
M.DashboardMruIcon = { fg = p.ui.accent }
M.DashboardMruTitle = { fg = p.ui.fg_chrome }
M.DashboardProjectIcon = { fg = p.ui.accent }
M.DashboardProjectTitle = { fg = p.ui.fg_chrome }
M.DashboardRecentProjectIcon = { fg = p.ui.accent }
M.DashboardShortCut = { fg = p.ui.fg_chrome }
M.DashboardShortCutIcon = { fg = p.ui.accent }

M.FlashBackdrop = { fg = p.ui.decoration }
M.FlashCurrent = { fg = p.ui.fg_on_fill, bg = p.ui.accent }
M.FlashLabel = { fg = p.ui.fg_on_fill, bg = p.ui.accent, bold = true }
M.FlashMatch = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.FlashPromptIcon = { fg = p.ui.accent }

M.FzfLuaBorder = { link = "FloatBorder" }
M.FzfLuaBufNr = { fg = p.ui.fg_dim }
M.FzfLuaCursorLine = { link = "CursorLine" }
M.FzfLuaCursorLineNr = { link = "CursorLineNr" }
M.FzfLuaFzfHeader = { fg = p.ui.fg_muted }
M.FzfLuaFzfInfo = { fg = p.ui.fg_dim }
M.FzfLuaFzfMarker = { fg = p.ui.fg_chrome }
M.FzfLuaFzfMatch = { fg = p.ui.accent }
M.FzfLuaFzfPointer = { fg = p.ui.fg_chrome }
M.FzfLuaFzfPrompt = { fg = p.ui.accent }
M.FzfLuaHeaderBind = { fg = p.ui.fg_dim }
M.FzfLuaHeaderText = { fg = p.ui.fg_chrome }
M.FzfLuaLivePrompt = { fg = p.ui.accent }
M.FzfLuaNormal = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.FzfLuaPathColNr = { fg = p.ui.fg_dim }
M.FzfLuaPreviewBorder = { link = "FloatBorder" }
M.FzfLuaPreviewNormal = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.FzfLuaPreviewTitle = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface, bold = true }
M.FzfLuaPrompt = { fg = p.ui.accent }
M.FzfLuaSearch = { fg = p.ui.fg_on_fill, bg = p.ui.accent }
M.FzfLuaTitle = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface, bold = true }

M.GrugFarCurrentMatch = { fg = p.ui.fg_on_fill, bg = p.ui.accent }
M.GrugFarHelpHeader = { fg = p.ui.fg_chrome }
M.GrugFarHelpHeaderKey = { fg = p.ui.accent }
M.GrugFarInputLabel = { fg = p.ui.fg_chrome }
M.GrugFarInputPlaceholder = { fg = p.ui.fg_muted }
M.GrugFarResultsAddIndicator = { fg = p.syn.string }
M.GrugFarResultsChangeIndicator = { fg = p.ui.fg_chrome }
M.GrugFarResultsCmdHeader = { fg = p.ui.fg_dim }
M.GrugFarResultsCursorLineNo = { link = "CursorLineNr" }
M.GrugFarResultsHeader = { fg = p.ui.fg_chrome }
M.GrugFarResultsLineNr = { link = "LineNr" }
M.GrugFarResultsMatch = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.GrugFarResultsMatchAdded = { fg = p.syn.string }
M.GrugFarResultsMatchRemoved = { fg = p.syn.preproc }

M.LazyBold = { bold = true }
M.LazyButton = { fg = p.ui.fg_chrome }
M.LazyButtonActive = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.LazyComment = { fg = p.ui.fg_muted }
M.LazyCommit = { fg = p.ui.fg_muted }
M.LazyCommitType = { fg = p.ui.fg_chrome }
M.LazyDimmed = { fg = p.ui.fg_muted }
M.LazyDir = { fg = p.ui.fg_dim }
M.LazyDone = { fg = p.diag.ok }
M.LazyError = { fg = p.diag.error }
M.LazyH1 = { fg = p.ui.fg_chrome, bold = true }
M.LazyH2 = { fg = p.ui.fg_chrome }
M.LazyInfo = { fg = p.diag.info }
M.LazyItalic = { italic = true }
M.LazyNoCond = { fg = p.ui.fg_muted }
M.LazyNormal = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.LazyProgressDone = { fg = p.diag.ok }
M.LazyProgressTodo = { fg = p.ui.fg_muted }
M.LazySpecial = { fg = p.syn.special }
M.LazyWarning = { fg = p.diag.warn }

M.MarkSignHL = { fg = p.ui.accent }
M.MarkSignNumHL = { link = "LineNr" }
M.MarkVirtTextHL = { fg = p.ui.fg_muted }

M.MasonBackdrop = { bg = p.ui.bg }
M.MasonError = { fg = p.diag.error }
M.MasonHeader = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill, bold = true }
M.MasonHeaderSecondary = { fg = p.ui.fg_on_fill, bg = p.ui.accent, bold = true }
M.MasonHeading = { fg = p.ui.fg_chrome, bold = true }
M.MasonHighlight = { fg = p.ui.accent }
M.MasonHighlightBlock = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.MasonHighlightBlockBold = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill, bold = true }
M.MasonHighlightBlockBoldSecondary = { fg = p.ui.fg_on_fill, bg = p.ui.accent, bold = true }
M.MasonHighlightBlockSecondary = { fg = p.ui.fg_on_fill, bg = p.ui.accent }
M.MasonHighlightSecondary = { fg = p.ui.fg }
M.MasonLink = { link = "MasonHighlight" }
M.MasonMuted = { fg = p.ui.fg_muted }
M.MasonMutedBlock = { fg = p.ui.fg, bg = p.ui.bg_hover }
M.MasonMutedBlockBold = { fg = p.ui.fg, bg = p.ui.bg_hover, bold = true }
M.MasonNormal = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.MasonWarning = { fg = p.diag.warn }

M.MiniIconsAzure = { fg = p.syn.type }
M.MiniIconsBlue = { fg = p.syn.string }
M.MiniIconsCyan = { fg = p.diag.info }
M.MiniIconsGreen = { fg = p.diag.ok }
M.MiniIconsGrey = { fg = p.ui.fg_muted }
M.MiniIconsOrange = { fg = p.diag.warn }
M.MiniIconsPurple = { fg = p.syn.special }
M.MiniIconsRed = { fg = p.diag.error }
M.MiniIconsYellow = { fg = p.diag.warn_fill }

M.NoiceCmdline = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.NoiceCmdlinePopup = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.NoiceCmdlinePopupBorder = { link = "FloatBorder" }
M.NoiceCmdlinePopupTitle = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface, bold = true }
M.NoiceConfirm = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.NoiceConfirmBorder = { link = "FloatBorder" }
M.NoiceFormatConfirm = { fg = p.diag.ok }
M.NoiceFormatEvent = { fg = p.ui.fg_chrome }
M.NoiceFormatKind = { fg = p.ui.fg_dim }
M.NoiceFormatLevelError = { fg = p.diag.error }
M.NoiceFormatLevelInfo = { fg = p.diag.info }
M.NoiceFormatLevelWarn = { fg = p.diag.warn }
M.NoiceFormatProgressDone = { fg = p.diag.ok }
M.NoiceFormatProgressTodo = { fg = p.ui.fg_muted }
M.NoiceFormatTitle = { fg = p.ui.fg_chrome, bold = true }
M.NoiceLspProgressClient = { fg = p.ui.fg_muted }
M.NoiceLspProgressSpinner = { fg = p.ui.accent }
M.NoiceLspProgressTitle = { fg = p.ui.fg_chrome }
M.NoiceMini = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.NoicePopup = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.NoicePopupBorder = { link = "FloatBorder" }
M.NoicePopupmenu = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.NoicePopupmenuBorder = { link = "FloatBorder" }
M.NoicePopupmenuMatch = { fg = p.ui.accent }
M.NoicePopupmenuSelected = { fg = p.ui.fg_on_fill, bg = p.ui.bg_fill }
M.NoiceVirtualText = { fg = p.ui.fg_muted }

-- outline.nvim installs its defaults once, at setup. A later :colorscheme
-- clears them and nothing rebuilds them, so lain owns them outright.
M.OutlineCurrent = { fg = p.syn.string, bg = p.ui.bg_surface }
M.OutlineDetails = { fg = p.ui.fg_muted }
M.OutlineFoldMarker = { fg = p.ui.fg_chrome }
M.OutlineGuides = { fg = p.ui.rule }
M.OutlineHelpTip = { fg = p.ui.fg_muted }
M.OutlineJumpHighlight = { link = "Visual" }
M.OutlineKeymapHelpDisabled = { fg = p.ui.fg_muted }
M.OutlineKeymapHelpKey = { fg = p.syn.special }
M.OutlineLineno = { link = "LineNr" }
M.OutlineStatusError = { fg = p.diag.error }
M.OutlineStatusFt = { fg = p.syn.type }
M.OutlineStatusProvider = { fg = p.syn.special }

M.SnacksNormal = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksNormalNC = { link = "SnacksNormal" }
M.SnacksNotifierDebug = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksNotifierError = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksNotifierHistory = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksNotifierHistoryTitle = { fg = p.ui.fg_chrome }
M.SnacksNotifierInfo = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksNotifierMinimal = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksNotifierTrace = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksNotifierWarn = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksPicker = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksPickerBorder = { link = "FloatBorder" }
M.SnacksPickerCursorLine = { link = "CursorLine" }
M.SnacksPickerDir = { fg = p.ui.fg_dim }
M.SnacksPickerFooter = { link = "FloatFooter" }
M.SnacksPickerIcon = { fg = p.syn.special }
M.SnacksPickerInput = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksPickerMatch = { fg = p.ui.accent }
M.SnacksPickerPreview = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.SnacksPickerPrompt = { fg = p.syn.special }
M.SnacksPickerSelected = { fg = p.ui.accent }
M.SnacksPickerTitle = { link = "FloatTitle" }
M.SnacksPickerTotals = { fg = p.ui.fg_dim }

M.TodoBgFIX = { fg = p.ui.alert_fg, bg = p.ui.alert }
M.TodoBgHACK = { fg = p.ui.fg_on_fill, bg = p.diag.warn_fill }
M.TodoBgNOTE = { fg = p.diag.hint, bg = p.ui.bg_surface }
M.TodoBgPERF = { fg = p.diag.ok, bg = p.diag.ok_fill }
M.TodoBgTEST = { fg = p.diag.info, bg = p.ui.bg_surface }
M.TodoBgTODO = { fg = p.diag.info, bg = p.ui.bg_surface }
M.TodoBgWARN = { fg = p.ui.fg_on_fill, bg = p.diag.warn_fill }
M.TodoFgFIX = { fg = p.diag.error }
M.TodoFgHACK = { fg = p.diag.warn }
M.TodoFgNOTE = { fg = p.diag.hint }
M.TodoFgPERF = { fg = p.diag.ok }
M.TodoFgTEST = { fg = p.diag.info }
M.TodoFgTODO = { fg = p.diag.info }
M.TodoFgWARN = { fg = p.diag.warn }
M.TodoSignFIX = { fg = p.diag.error }
M.TodoSignHACK = { fg = p.diag.warn }
M.TodoSignNOTE = { fg = p.diag.hint }
M.TodoSignPERF = { fg = p.diag.ok }
M.TodoSignTEST = { fg = p.diag.info }
M.TodoSignTODO = { fg = p.diag.info }
M.TodoSignWARN = { fg = p.diag.warn }

M.TroubleCount = { fg = p.ui.fg_dim }
M.TroubleIcon = { fg = p.ui.fg_chrome }
M.TroubleIndent = { link = "WinSeparator" }
M.TroubleNormal = { fg = p.ui.fg, bg = p.ui.bg }
M.TroubleNormalNC = { link = "TroubleNormal" }
M.TroublePos = { fg = p.ui.fg_dim }
M.TroublePreview = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.TroubleSource = { fg = p.ui.fg_dim }
M.TroubleStatusline = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface }
M.TroubleText = { fg = p.syn.text }

M.WhichKeyBorder = { link = "FloatBorder" }
M.WhichKeyDesc = { fg = p.ui.fg_dim }
M.WhichKeyGroup = { fg = p.ui.fg_chrome }
M.WhichKeyIcon = { fg = p.syn.special }
M.WhichKeyNormal = { fg = p.ui.fg, bg = p.ui.bg_surface }
M.WhichKeySeparator = { fg = p.ui.fg_dim }
M.WhichKeyTitle = { fg = p.ui.fg_chrome, bg = p.ui.bg_surface, bold = true }
M.WhichKeyValue = { fg = p.ui.fg_muted }

return M
