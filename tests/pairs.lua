-- Context map: fg-bearing groups that render on a non-Normal surface.
return {
  surfaces = {
    PmenuKind = "Pmenu",
    PmenuKindSel = "PmenuSel",
    PmenuExtra = "Pmenu",
    PmenuExtraSel = "PmenuSel",
    PmenuThumb = "PmenuSbar",
    CursorLineNr = "CursorLine",
    FloatTitle = "NormalFloat",
    FloatFooter = "NormalFloat",

    -- The fzf-lua window has its own ground, so these render on FzfLuaNormal
    -- rather than on Normal. Measuring them against Normal's black reads as
    -- more contrast than they actually have.
    FzfLuaBufFlagAlt = "FzfLuaNormal",
    FzfLuaBufFlagCur = "FzfLuaNormal",
    FzfLuaBufNr = "FzfLuaNormal",
    FzfLuaFzfHeader = "FzfLuaNormal",
    FzfLuaFzfInfo = "FzfLuaNormal",
    FzfLuaFzfMarker = "FzfLuaNormal",
    FzfLuaFzfMatch = "FzfLuaNormal",
    FzfLuaFzfPointer = "FzfLuaNormal",
    FzfLuaFzfPrompt = "FzfLuaNormal",
    FzfLuaHeaderBind = "FzfLuaNormal",
    FzfLuaHeaderText = "FzfLuaNormal",
    FzfLuaLivePrompt = "FzfLuaNormal",
    FzfLuaLiveSym = "FzfLuaNormal",
    FzfLuaPathColNr = "FzfLuaNormal",
    FzfLuaPathLineNr = "FzfLuaNormal",
    FzfLuaTabMarker = "FzfLuaNormal",
    FzfLuaTabTitle = "FzfLuaNormal",
  },
}
