-- luacheck configuration. tests/lint.sh runs luacheck from the repo root, so
-- this is the single source for the flags; a bare `luacheck .` picks it up too.

-- Writable, not read_globals: colors/lain.lua and lua/lain/terminal.lua set
-- vim.g and vim.o fields, which read-only globals report as warnings.
globals = { "vim" }

max_line_length = 120

exclude_files = { ".omo" }
