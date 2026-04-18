-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.maplocalleader = ","
-- vim.g.lazyvim_python_lsp = "basedpyright"
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h13"
  vim.opt.linespace = 1
  vim.g.neovide_opacity = 0.8
  vim.g.neovide_normal_opacity = 0.8
end
