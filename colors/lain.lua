-- Colorscheme entry: clear, colors_name, termguicolors, then load.
vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end
vim.g.colors_name = "lain"
vim.o.termguicolors = true
if vim.o.background ~= "dark" then
  vim.o.background = "dark"
end
require("lain").load()
