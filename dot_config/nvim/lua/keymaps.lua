-- [[ Basic Keymaps ]]
local opts = { noremap = true, silent = true }
local custom_functions = require("custom_functions")
-- local plugins_config = require("plugins_configuration")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-------------------
-- -- GENERAL -- --
-------------------
vim.keymap.set("n", "<leader><BS>", ":wqa<CR>", { desc = "Exit neovim", opts.args })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Force Exit neovim", opts.args })

-- open configuration files
local configuration_directory_path = vim.api.nvim_list_runtime_paths()[1]
Last_working_directory = nil
vim.keymap.set("n", "<leader>;", function()
  local current_dir = vim.fn.getcwd()
  if current_dir ~= configuration_directory_path then
    -- save last working directory
    Last_working_directory = current_dir
    -- cd to config and open a telescope prompt in a new tab
    vim.cmd("tabnew")
    vim.api.nvim_set_current_dir(configuration_directory_path)
    -- plugins_config.project_files()
  elseif #vim.api.nvim_list_tabpages() > 1 then
    -- close tab and revert to last working directory if there is one
    vim.cmd("tabclose")
    if Last_working_directory ~= nil then
      vim.api.nvim_set_current_dir(Last_working_directory)
    end
  end
end, { desc = "Toggle config files", opts.args })

-----------------------
-- -- NORMAL MODE -- --
-----------------------

-- WINDOWS
-- ----------------------------------------------------------------------------------------
-- Navigating between open windows
-- NOTE: this seems to be overwritten by tmux-navigator
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window on the right", opts.args })
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window on the left", opts.args })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below", opts.args })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above", opts.args })
-- Quit window, except if it is the last one (ie does not quit vim)!
vim.keymap.set("n", "<leader>q", ":close<CR>", { desc = "Quit window", opts.args })
vim.keymap.set("n", "<C-w>o", "<CMD>only<CR>", { desc = "Quit other windows", opts.args })

-- Resize with arrows
vim.keymap.set("n", "<M-Up>", "<cmd>resize +2<CR>", { desc = "Resize up", opts.args })
vim.keymap.set("n", "<M-Down>", "<cmd>resize -2<CR>", { desc = "Resize down", opts.args })
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize left", opts.args })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize right", opts.args })

-- BUFFERS
-- ----------------------------------------------------------------------------------------
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save changes in current buffer", opts.args })
-- this is now handled by bufremove plugin
-- vim.keymap.set("n", "<leader>c", "<CMD>:bp<CR><CMD>:bd#<CR>", { desc = "Close buffer", opts.args })
vim.keymap.set("n", "<leader>c", "<cmd>BufferKill<CR>", { desc = "Close buffer", opts.args })
vim.keymap.set("n", "<leader>C", "<CMD>:bp<CR><CMD>:bd!#<CR>", { desc = "Close buffer (force)", opts.args })
-- yank current buffer file path
vim.keymap.set("n", "<leader>y", '<cmd>let @+ = expand("%")<cr>', { desc = "Yank current file path", opts.args })

-- QUICKLIST NAVIGATION
-- ----------------------------------------------------------------------------------------
-- NOTE: this needs to be remapped since it conflicts with <leader>q
vim.keymap.set("n", "<leader>mo", ":copen 25<CR>", { desc = "quicklist open", opts.args })
vim.keymap.set("n", "<leader>m]", ":cn<CR>", { desc = "quicklist next", opts.args })
vim.keymap.set("n", "<leader>m[", ":cp<CR>", { desc = "quicklist prev", opts.args })
-- vim.keymap.set("n", "<leader>qn", ":cn<CR>zz", { desc = "Quicklist next", opts.args })
-- vim.keymap.set("n", "<leader>qp", ":cp<CR>zz", { desc = "Quicklist prev", opts.args })
-- vim.keymap.set("n", "<leader>qo", ":copen 15<CR>", { desc = "Quicklist open", opts.args })
-- vim.keymap.set("n", "<leader>qO", ":copen<CR>", { desc = "Quicklist open (dispatched)", opts.args })
-- vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Quicklist close", opts.args })
-- vim.keymap.set("n", "<leader>qi", ":cclose<CR>", { desc = "Quicklist close", opts.args })
-- vim.keymap.set("n", "<leader>qq", ":cc<CR>zz", { desc = "Quicklist show current", opts.args })
-- vim.keymap.set("n", "<leader>qN", ":cfirst<CR>", { desc = "Quicklist first", opts.args })
-- vim.keymap.set("n", "<leader>qP", ":clast<CR>", { desc = "Quicklist last", opts.args })

-- MISCELLANEOUS
-- ----------------------------------------------------------------------------------------
-- Wrap/unwrap
vim.keymap.set("n", "<leader>vw", ":setlocal wrap<CR>", { desc = "Wrap text", opts.args })
vim.keymap.set("n", "<leader>vW", ":setlocal nowrap<CR>", { desc = "Unwrap text", opts.args })
-- Remap for dealing with word wrap
-- TODO: is this useful ?
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- hl/nohl search
-- TODO: see hlsearch command and use the suggested autocommand to remove hls on search mode exit
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No highligth search", opts.args })

-- Launch terminal command
-- vim.keymap.set(
--   "n",
--   "<leader>T",
--   ":below split | terminal<CR>",
--   { noremap = true, silent = false, desc = "Launch terminal horizontal" }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>t",
--   ":rightbelow vsplit | terminal<CR>",
--   { noremap = true, silent = false, desc = "Launch terminal vertical" }
-- )

-- help
vim.keymap.set(
  "n",
  "<leader>H",
  ":vertical rightbelow help<Space>",
  { noremap = true, silent = false, desc = "Vim help" }
)

-- Replace under cursor
-- vim.keymap.set(
--   "n",
--   "<leader>S",
--   ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
--   { noremap = true, silent = false, desc = "Search and replace word" }
-- )

-- Set (local) folding
vim.keymap.set("n", "<leader>zi", ":setlocal foldmethod=indent<CR>", { desc = "Fold w.r.t indent", opts.args })

-----------------------
-- -- INSERT MODE -- --
-----------------------

-- Better navigation in insert mode
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "right", opts.args })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "left", opts.args })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "up one line", opts.args })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "down one line", opts.args })

-----------------------
-- -- VISUAL MODE -- --
-----------------------
-- Move lines around - visual
vim.keymap.set("v", ">", ">gv", { desc = "Indent", opts.args })
vim.keymap.set("v", "<", "<gv", { desc = "Unindent", opts.args })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines up", opts.args })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines down", opts.args })

-- Keep what is in register when pasting in visual mode
vim.keymap.set("v", "p", '"_dP', { desc = "Paste", opts.args })

-------------------------
-- -- TERMINAL MODE -- --
-------------------------
-- local topts = { silent = true }
-- vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Escape", topts.args })

-----------------------
-- -- DIAGNOSTICS -- --
-----------------------
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>k", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-----------------------------------------------
-----------------------------------------------
--            PLUGINS KEYMAPS                --
-----------------------------------------------
-----------------------------------------------

-- NEO TREE
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle neo-tree", opts.args })
vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle float<cr>", { desc = "Toggle neo-tree float", opts.args })

-- OIL
vim.keymap.set("n", "<leader>o", "<cmd>Oil %:h<cr>", { desc = "Open Oil buffer", opts.args })

-- SPECTRE
vim.keymap.set("n", "<leader>S", function()
  require("spectre").open()
end, { desc = "Replace in files (Spectre)", opts.args })

-- FUGITIVE / NEOGIT
local neogit = require("neogit")
vim.keymap.set("n", "<leader>gg", function()
  neogit.open({ kind = "auto" })
end, { desc = "open fugitive status panel", opts.args })
vim.keymap.set("n", "<leader>gl", "<cmd>vertical rightbelow G log<CR>", { desc = "open fugitive logs", opts.args })
vim.keymap.set("n", "<leader>gc", ":G checkout ", { desc = "checkout", opts.args })
vim.keymap.set("n", "<leader>grr", ":G pull --rebase<CR>", { desc = "rebase on origin self", opts.args })
vim.keymap.set(
  "n",
  "<leader>grm",
  ":G pull --rebase origin master<CR>",
  { desc = "rebase on origin master", opts.args }
)
vim.keymap.set("n", "<leader>gmc", ":Gvdiffsplit!<CR>", { desc = "resolve merge conflict", opts.args })

-- TELESCOPE
vim.keymap.set("n", "<C-p>", custom_functions.project_files, { desc = "Telescope git files", opts.args })
vim.keymap.set("n", "<leader>st", "<cmd>Telescope live_grep<cr>", { desc = "Telescope grep", opts.args })
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<cr>", { desc = "Telescope live grep", opts.args })
vim.keymap.set("n", "<leader>tc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope git commits", opts.args })
vim.keymap.set(
  "n",
  "<leader>tC",
  "<cmd>Telescope git_bcommits<cr>",
  { desc = "Telescope current buffer git commits", opts.args }
)
vim.keymap.set("n", "<leader>tb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope git branches", opts.args })
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope git_status<cr>", { desc = "Telescope git status", opts.args })
vim.keymap.set("n", "<leader>tS", "<cmd>Telescope git_stash<cr>", { desc = "Telescope git stash", opts.args })
vim.keymap.set("n", "<leader>P", custom_functions.open_projects, { desc = "Telescope open projects", opts.args })
vim.keymap.set(
  "n",
  "<leader>tp",
  custom_functions.colorschemes_with_preview,
  { desc = "Telescope colorschemes", opts.args }
)

-- GOTO PREVIEW
vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
-- TODO: autocmmand to map escape to `close_all_win` when in goto preview buffer
vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")

-- PERSISTENCE (SESSION MGMT)
vim.keymap.set(
  "n",
  "<leader>ss",
  "<cmd>lua require('persistence').load({ last = true })<cr>",
  { desc = "load last session" }
)

-- FLASH
vim.keymap.set({ "n", "o", "x" }, "s", function()
  require("flash").jump()
end, { desc = "flash", opts.args })

-- ZEN MODE
vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").toggle({
    window = {
      backdrop = 0.95,
      width = 0.65, -- width will be 85% of the editor width
    },
    plugins = {
      twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
    },
  })
end, { desc = "Zen mode" })

-- NEORG
vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<cr>", { desc = "go to index", opts.args })
vim.keymap.set(
  "n",
  "<leader>ne",
  ":Neorg export to-file .md<Left><Left><Left>",
  { desc = "export to markdown", opts.args }
)

-- OCTO
-- vim.keymap.set(
--   "n",
--   "<leader>oo",
--   "<cmd>Octo search review-requested:@me is:pr is:open<cr>",
--   { desc = "PRs waiting for my review", opts.args }
-- )

-- AERIAL
vim.keymap.set("n", "<leader>lo", "<cmd>AerialToggle!<CR>", { desc = "Toggle symbols outline", opts.args })

-- DAP
vim.keymap.set("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint", opts.args })
vim.keymap.set("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Continue", opts.args })
vim.keymap.set("n", "<leader>ds", function()
  require("dap").step_into()
end, { desc = "Step into", opts.args })
vim.keymap.set("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open repl", opts.args })

-- WHICH-KEY MAPPINGS
local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    m = {
      name = "Quickfix",
    },
    n = {
      name = "Neorg",
      n = { "<cmd>Neorg index<cr>", "index" },
    },
    d = {
      name = "DAP",
    },
    g = {
      name = "Git",
    },
    l = {
      name = "Lsp",
    },
    v = {
      name = "Wrap Options",
    },
    z = {
      name = "Misc",
    },
    s = {
      name = "Search",
    },
    t = {
      name = "Telescope",
    },
  },
})

-- LSP-specific
vim.keymap.set("n", "<leader>lpd", function()
  require("lspconfig").pyright.setup({
    settings = {
      pyright = {
        reportMissingImports = true,
        typeCheckingMode = "off",
      },
    },
  })
end, { desc = "disable type checking", opts.args })
vim.keymap.set("n", "<leader>lpe", function()
  require("lspconfig").pyright.setup({
    settings = {
      pyright = {
        reportMissingImports = true,
        typeCheckingMode = "standard",
      },
    },
  })
end, { desc = "enable type checking", opts.args })
