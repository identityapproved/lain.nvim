-- Runtime entry: setup, the version gate, and highlight application.
local M = {}

M.config = nil

-- Loading runs inside the :colorscheme command, where a real error message is
-- not a message: Vim turns it into a thrown exception and the command aborts
-- half-applied. nvim_err_writeln does that (and is deprecated besides), and
-- vim.notify routes through it. An echo in ErrorMsg reads the same, reaches
-- :messages and headless stderr, and lets the load finish.
function M.report(msg)
  vim.api.nvim_echo({ { msg, "ErrorMsg" } }, true, {})
end

function M.setup(opts)
  M.config = require("lain.config").resolve(opts or {})
  return M.config
end

function M.load()
  if M.config == nil then
    M.setup()
  end
  if vim.fn.has("nvim-0.11") == 0 then
    M.report("lain.nvim requires Neovim 0.11 or newer; refusing to load")
    return
  end
  local groups = require("lain.groups").highlight_groups(M.config)
  -- Set each group on its own. A spec nvim rejects is almost always one an
  -- on_highlights hook wrote, and naming the group beats an unstyled editor and
  -- a stack trace pointing at this loop.
  local bad = {}
  for name, spec in pairs(groups) do
    local ok, err = pcall(vim.api.nvim_set_hl, 0, name, spec)
    if not ok then
      bad[#bad + 1] = name .. " (" .. tostring(err) .. ")"
    end
  end
  if #bad > 0 then
    table.sort(bad)
    M.report("lain: skipped bad highlight spec for " .. table.concat(bad, ", "))
  end
  if M.config.terminal_colors then
    require("lain.terminal").apply()
  end
end

return M
