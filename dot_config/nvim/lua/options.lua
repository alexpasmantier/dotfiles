-- [[ Setting options ]]
M = {}

-- See `:help vim.o`
vim.o.encoding = "utf-8"

vim.g.have_nerd_font = true

-- Set highlight on search
vim.o.hlsearch = true
-- clear hl when hitting esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.o.incsearch = true
vim.o.inccommand = "split"

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- The cursor always has room above and below
vim.o.scrolloff = 10

-- check spelling
vim.o.spell = false

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Do not continue comments on new line
-- (the autocmd is a workaround to the fact that this gets overriden by default ftplugins)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})

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
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.smartindent = true
vim.wo.signcolumn = "yes"
vim.o.showbreak = "> "
vim.o.linebreak = true -- so that wrapping does not occur in middle of word
vim.o.textwidth = 120
-- vim.o.nolist = true -- same as above

-- Modify jumplist behavior
vim.cmd([[
  autocmd InsertLeave * normal! m'
  autocmd TextYankPost * normal! m'
  autocmd BufWrite * normal! m'
]])
vim.o.jumpoptions = ""

-- Configure how new splits should open
vim.o.splitbelow = true
vim.o.splitright = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Fillchars
vim.opt.fillchars = { eob = " ", vert = "│" }

-- Set colorscheme
vim.o.background = "light"
M.light_colorscheme = "solarized8_flat"
M.dark_colorscheme = "vague"

vim.o.termguicolors = true

-- Don't wrap please
vim.o.wrap = false

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
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false
vim.o.foldlevel = 99

-- [[NEOVIDE]]
-- ------------------------------------------------------------------------------------------------
if vim.g.neovide then
  vim.o.guifont = "BerkeleyMono Nerd Font"
  vim.g.neovide_scale_factor = 1
  vim.g.neovide_fullscreen = false
  vim.g.neovide_input_macos_option_key_is_meta = true
  vim.g.neovide_cursor_animation_length = 0.08
  vim.g.neovide_cursor_trail_size = 0.4
end

-- [[FIRENVIM]]
-- ------------------------------------------------------------------------------------------------
if vim.g.started_by_firenvim == true then
  vim.g.expanded_modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
  }
  vim.o.statusline = "%{expanded_modes[mode()]} %m%r%=%y  %-14.(%l,%c%V%) %P"
  vim.o.wrap = true
  vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
      [".*"] = {
        cmdline = "neovim",
        content = "text",
        priority = 0,
        selector = "textarea",
        takeover = "never",
      },
    },
  }
end
