-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.encoding = "utf-8"

-- neovide configuration
if vim.g.neovide then
  vim.o.guifont = "JetBrains Mono"
  vim.g.neovide_scale_factor = 0.9
  vim.g.neovide_fullscreen = true
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_cursor_animation_length = 0.08
  vim.g.neovide_cursor_trail_size = 0.4
end

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- The cursor always has room above and below
vim.o.scrolloff = 8

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- No swapfile
vim.o.swapfile = false

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Do not show current mode (status line already does)
vim.o.showmode = false

-- Highlight cursorline
vim.o.cursorline = true

-- Decrease update time
vim.o.updatetime = 500
vim.o.timeoutlen = 500

vim.o.smartindent = true
vim.wo.signcolumn = "yes"
vim.o.showbreak = "> "
vim.o.linebreak = true -- so that wrapping does not occur in middle of word
vim.o.nolist = true    -- same as above

-- Modify jumplist behavior -> much better
vim.cmd([[
  autocmd InsertLeave * normal! m'
  autocmd TextYankPost * normal! m'
  autocmd BufWrite * normal! m'
]])
vim.o.jumpoptions = ""

vim.o.splitbelow = true
vim.o.splitright = true

-- Set colorscheme
vim.o.termguicolors = true
-- vim.cmd([[colorscheme dogrun]])
-- vim.cmd([[colorscheme nord]])
vim.cmd([[colorscheme catppuccin-mocha]])
-- vim.cmd([[colorscheme kanagawa]])
-- vim.cmd([[colorscheme dayfox]])

-- Don't wrap please
vim.o.wrap = false

-- Relative line numbers
vim.o.relativenumber = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

-- Allow vim to access the system clipboard
vim.o.clipboard = "unnamedplus"

-- Maximum height of the completion window
vim.o.pumheight = 15

vim.o.conceallevel = 1

-- disable netrw alltogether
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- treesitter based folding
vim.o.foldmethod = "indent"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false


-- Override highlight groups
vim.api.nvim_set_hl(0, 'Comment', { ctermfg = 60, fg = "#545c8c", italic = true })
vim.api.nvim_set_hl(0, '@string.documentation', { fg = "#545c8c", italic = true })
-- tweaks for dogrun
-- vim.api.nvim_set_hl(0, 'lualine_a_normal', { bg = "#929be5", fg = "#252738", bold = true })
-- vim.api.nvim_set_hl(0, 'lualine_b_normal', { bg = "#252738", fg = "#929be5" })
