-- Runtime entry: setup, the version gate, and highlight application.
local M = {}

M.config = nil

function M.setup(opts)
  M.config = require("lain.config").resolve(opts or {})
  return M.config
end

function M.load()
  if M.config == nil then
    M.setup()
  end
  if vim.fn.has("nvim-0.11") == 0 then
    vim.api.nvim_err_writeln("lain.nvim requires Neovim 0.11 or newer; refusing to load")
    return
  end
  local groups = require("lain.groups").highlight_groups(M.config)
  for name, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, name, spec)
  end
  if M.config.terminal_colors then
    require("lain.terminal").apply()
  end
end

return M
