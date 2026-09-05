-- Context map: fg-bearing groups that render on a non-Normal surface.
--
-- A group with no bg of its own and no link inherits the ground of whatever
-- window it is drawn in. Measuring one against Normal's black when it actually
-- lands on a float's bg_surface reads as more contrast than it has, so the
-- floors get checked against a ground the user never sees.
return {
  -- Individual groups whose surface is not their family's.
  surfaces = {
    PmenuKind = "Pmenu",
    PmenuKindSel = "PmenuSel",
    PmenuExtra = "Pmenu",
    PmenuExtraSel = "PmenuSel",
    PmenuThumb = "PmenuSbar",
    CursorLineNr = "CursorLine",
    FloatTitle = "NormalFloat",
    FloatFooter = "NormalFloat",
    SnacksNotifierHistoryTitle = "SnacksNotifierHistory",
  },

  -- Whole families that draw inside a window of their own. Listed by prefix so
  -- a group added to one of them is measured against the right ground without
  -- anyone remembering to come back here. Only families whose ground differs
  -- from Normal's belong on this list: Trouble and dap-ui paint ui.bg, the same
  -- black Normal has, so they resolve correctly already.
  families = {
    { prefix = "BlinkCmp", surface = "BlinkCmpMenu" },
    { prefix = "FzfLua", surface = "FzfLuaNormal" },
    { prefix = "Lazy", surface = "LazyNormal" },
    { prefix = "Mason", surface = "MasonNormal" },
    { prefix = "Noice", surface = "NoicePopup" },
    { prefix = "SnacksPicker", surface = "SnacksPicker" },
    { prefix = "WhichKey", surface = "WhichKeyNormal" },
  },

  -- Exceptions to the family rule: these carry their plugin's prefix but are
  -- drawn over the buffer, not inside the plugin's window, so Normal is the
  -- correct ground for them after all.
  on_normal = {
    BlinkCmpGhostText = true,
    NoiceVirtualText = true,
  },
}
