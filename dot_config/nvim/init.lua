vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.vscode then
	-- ordinary Neovim
	require "options"

	require "keymaps"
else
	-- VSCode
	require "plugins"

	require "plugins_configuration"

	require "options"

	require "keymaps"

	require "autocmds"

	require "commands"

	require "lsp"
end
