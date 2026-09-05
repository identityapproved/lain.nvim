-- :checkhealth lain - the two hard requirements, then what the theme resolved to.
local M = {}

local health = vim.health

local function version()
  local v = vim.version()
  return string.format("%d.%d.%d", v.major, v.minor, v.patch)
end

local function check_version()
  health.start("Neovim version")
  if vim.fn.has("nvim-0.11") == 1 then
    health.ok("nvim " .. version())
  else
    health.error("nvim " .. version() .. ", lain requires 0.11 or newer", {
      "lain.load() refuses to apply below 0.11 rather than half-apply.",
      "Upgrade Neovim, or pin a colorscheme that supports this version.",
    })
  end
end

local function check_truecolor()
  health.start("Truecolor")
  if vim.o.termguicolors then
    health.ok("termguicolors is on")
  else
    health.error("termguicolors is off", {
      "colors/lain.lua sets it; something turned it back off afterwards.",
      "Set vim.o.termguicolors = true after the colorscheme loads.",
    })
  end

  local colorterm = vim.env.COLORTERM
  if colorterm == "truecolor" or colorterm == "24bit" then
    health.ok("COLORTERM=" .. colorterm)
  elseif vim.env.TERM and vim.env.TERM:find("direct", 1, true) then
    health.ok("TERM=" .. vim.env.TERM .. " advertises direct color")
  else
    -- Not fatal: plenty of 24-bit terminals set neither. The ramps do need it,
    -- and there is no 256-colour fallback, so say so rather than stay quiet.
    health.warn("no 24-bit signal from COLORTERM or TERM", {
      "lain has no 256-colour fallback; the rose and ochre steps collapse without truecolor.",
      "If your terminal does support it, export COLORTERM=truecolor.",
    })
  end
end

local function check_active()
  health.start("Colorscheme")
  if vim.g.colors_name == "lain" then
    health.ok("lain is the active colorscheme")
  else
    health.warn("active colorscheme is " .. tostring(vim.g.colors_name), {
      "Run :colorscheme lain, or set it through your plugin manager.",
    })
  end

  if vim.o.background == "dark" then
    health.ok("background is dark")
  else
    health.warn("background is " .. vim.o.background .. "; lain is a dark theme only")
  end
end

local function check_config()
  health.start("Configuration")
  local ok, resolved = pcall(function()
    return require("lain.config").resolve(require("lain").config)
  end)
  if not ok then
    health.error("config does not resolve: " .. tostring(resolved), {
      "Fix the opts passed to require('lain').setup().",
    })
    return
  end
  health.ok("styles.visual = " .. resolved.styles.visual)
  health.ok("terminal_colors = " .. tostring(resolved.terminal_colors))
  health.ok("transparent = " .. tostring(resolved.transparent))
  if resolved.terminal_colors then
    local unset = {}
    for i = 0, 15 do
      if type(vim.g["terminal_color_" .. i]) ~= "string" then
        unset[#unset + 1] = tostring(i)
      end
    end
    if #unset == 0 then
      health.ok("all 16 terminal_color_* slots are set")
    else
      health.warn("terminal_color_* unset for slot(s) " .. table.concat(unset, ", "), {
        "Slots are written on load; reload with :colorscheme lain.",
      })
    end
  end
end

function M.check()
  check_version()
  check_truecolor()
  check_active()
  check_config()
end

return M
