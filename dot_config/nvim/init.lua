vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.vscode then
  -- VSCode
  require("options")

  require("keymaps")
else
  -- ordinary Neovim
  -- bootstrap lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("custom_functions")

  require("lazy").setup("plugins")

  require("options")

  require("keymaps")

  require("autocmds")

  require("commands")

  require("lsp")
end
