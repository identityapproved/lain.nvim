# lain.nvim

A Neovim colorscheme in the lain palette: black ground, rose chrome, ochre
text.

Rose carries the interface - statusline, titles, keywords. Ochre carries
content - body text, selection, search. Comments are a neutral grey, the one
unmistakable "this is not code" signal.

Requires Neovim 0.11 or newer and a truecolor terminal.

## Install

With lazy.nvim:

```lua
{
  "identityapproved/lain.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("lain")
  end,
}
```

Options are passed through lazy.nvim's opts:

```lua
{
  "identityapproved/lain.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    styles = { visual = "fill" },
    terminal_colors = true,
  },
  config = function()
    vim.cmd.colorscheme("lain")
  end,
}
```

Under LazyVim:

```lua
{
  "identityapproved/lain.nvim",
  priority = 1000,
},
{
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "lain",
  },
},
```

### Truecolor

The lain ramps need 24-bit color. Without it the rose and ochre steps quantise
onto the same xterm pink band and stop being distinguishable - `#A49978` lands
on a rose, and `#C1B48E` and `#B5A985` collapse onto one index. There is no
256-color fallback, by design.

## Options

| Option | Default | Meaning |
| --- | --- | --- |
| `styles.visual` | `"fill"` | Selection is an ochre fill with black text. `"tint"` is a dark tint with syntax left intact. |
| `terminal_colors` | `true` | Sets `g:terminal_color_0` through `g:terminal_color_15`. |
| `transparent` | `false` | Drops the background from the window ground so the terminal shows through. Floats, popups and the statusline keep their surface ground. |

## Plugins

Beyond the core and treesitter groups, lain styles blink.cmp,
bufferline.nvim, crates.nvim, dashboard-nvim, flash.nvim, fzf-lua,
grug-far.nvim, lazy.nvim, marks.nvim, mason.nvim, mini.icons, noice.nvim,
nvim-dap, nvim-dap-ui, nvim-dap-virtual-text, outline.nvim, snacks.nvim,
todo-comments.nvim, trouble.nvim and which-key.nvim.

Anything that only links to core groups needs no entry - it follows Normal,
Pmenu, FloatBorder and the diagnostic groups already. The list is the set that
names its own groups or ships hardcoded colors a colorscheme has to displace.

## Terminal colors

The sixteen ANSI slots are the palette's terminal mapping and match the lain
kitty theme, so `:terminal` inside nvim and a kitty tab agree. Green renders as
ochre, blue as grey; programs that hardcode "green means success" read as ochre
against rose for failure - the hue still separates, only the names lie.

## Health

```vim
:checkhealth lain
```

reports on the two hard requirements - Neovim 0.11 and truecolor - and on what
the theme resolved to: whether lain is active, the resolved options, and
whether all sixteen `terminal_color_*` slots are set. The truecolor result is a
warning rather than an error, since plenty of 24-bit terminals advertise
nothing.

## Tests

```sh
tests/run.sh
```

runs palette conformance (no raw hex outside `lua/lain/ramp.lua`, every token
bound to a ramp step), WCAG contrast over every rendered pair, a headless smoke
load, and a headless `:checkhealth` that must come back clean.

## Notes

Unofficial fan project. Not affiliated with, endorsed by, or connected to the
rights holders of Serial Experiments Lain. The code is MIT; no artwork, frames,
or logos are included or redistributed.
