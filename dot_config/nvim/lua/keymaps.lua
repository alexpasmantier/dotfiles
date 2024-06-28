-- [[ Basic Keymaps ]]
local opts = { noremap = true, silent = true }
local telescope_functions = require("custom_functions.telescope")
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
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window on the right", opts.args })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window on the left", opts.args })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below", opts.args })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above", opts.args })
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
-- not sure this is actually that useful
-- vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save changes in current buffer", opts.args })
-- this is now handled by bufremove plugin
-- vim.keymap.set("n", "<leader>c", "<CMD>:bp<CR><CMD>:bd#<CR>", { desc = "Close buffer", opts.args })
vim.keymap.set("n", "<leader>c", "<cmd>BufferKill<CR>", { desc = "Close buffer", opts.args })
vim.keymap.set("n", "<C-c>", "<cmd>BufferKill<CR>", { desc = "Close buffer", opts.args })
vim.keymap.set("n", "<leader>C", "<CMD>:bp<CR><CMD>:bd!#<CR>", { desc = "Close buffer (force)", opts.args })
-- yank current buffer file path
vim.keymap.set("n", "<leader>y", '<cmd>let @+ = expand("%")<cr>', { desc = "Yank current file path", opts.args })

-- QUICKLIST NAVIGATION
-- ----------------------------------------------------------------------------------------
-- NOTE: this needs to be remapped since it conflicts with <leader>q
vim.keymap.set("n", "<leader>mo", ":copen 25<CR>", { desc = "quicklist open", opts.args })
vim.keymap.set("n", "<leader>]", ":cn<CR>", { desc = "quicklist next", opts.args })
vim.keymap.set("n", "<leader>[", ":cp<CR>", { desc = "quicklist prev", opts.args })
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

-- Toggle inlay hints
-- vim.keymap.set("n", "<leader>ih", function()
--   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
-- end, { desc = "Toggle inlay hints" })

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
-- NOTE: this is now default in nvim 10.0
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-----------------------------------------------
-----------------------------------------------
--            PLUGINS KEYMAPS                --
-----------------------------------------------
-----------------------------------------------

if not vim.g.vscode then
  -- NEO TREE
  vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle neo-tree", opts.args })
  vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle float<cr>", { desc = "Toggle neo-tree float", opts.args })

  -- OIL
  vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Open Oil buffer", opts.args })

  -- SPECTRE
  vim.keymap.set("n", "<leader>S", function()
    require("spectre").open()
  end, { desc = "Replace in files (Spectre)", opts.args })
  vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word",
  })
  vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word",
  })

  -- FUGITIVE
  vim.keymap.set("n", "<leader>gmc", ":Gvdiffsplit!<CR>", { desc = "resolve merge conflict", opts.args })

  -- TELESCOPE
  local telescope_builtins = require("telescope.builtin")
  vim.keymap.set("n", "<C-p>", telescope_functions.project_files, { desc = "Telescope git files", opts.args })
  vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope live_grep<cr>", { desc = "Telescope grep", opts.args })
  vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>", { desc = "Telescope live grep", opts.args })
  vim.keymap.set("n", "<leader>tc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope git commits", opts.args })
  vim.keymap.set(
    "n",
    "<leader>tC",
    "<cmd>Telescope git_bcommits<cr>",
    { desc = "Telescope current buffer git commits", opts.args }
  )
  vim.keymap.set("n", "<leader>tB", "<cmd>Telescope git_branches<cr>", { desc = "Telescope git branches", opts.args })
  vim.keymap.set("n", "<leader>ts", "<cmd>Telescope git_status<cr>", { desc = "Telescope git status", opts.args })
  vim.keymap.set("n", "<leader>tS", "<cmd>Telescope git_stash<cr>", { desc = "Telescope git stash", opts.args })
  vim.keymap.set("n", "<leader>P", telescope_functions.open_projects, { desc = "Telescope open projects", opts.args })
  vim.keymap.set(
    "n",
    "<leader>tp",
    telescope_functions.colorschemes_with_preview,
    { desc = "Telescope colorschemes", opts.args }
  )
  vim.keymap.set("n", "<leader>tn", telescope_functions.search_notes, { desc = "Telescope note", opts.args })
  vim.keymap.set("n", "<leader>t.", telescope_functions.search_dotfiles, { desc = "Telescope dotfiles", opts.args })
  vim.keymap.set("n", "<leader>th", telescope_builtins.help_tags, { desc = "Telescope help tags", opts.args })

  -- GOTO PREVIEW
  vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
  vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
  -- TODO: autocmmand to map escape to `close_all_win` when in goto preview buffer
  vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")

  -- AERIAL
  vim.keymap.set("n", "<leader>lo", "<cmd>AerialToggle!<CR>", { desc = "Toggle symbols outline", opts.args })

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
end

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

-- COPILOT
-- set <c-e> for accepting copilot suggestions (and <c-d> to dismiss) and unmap tab
vim.keymap.set("i", "<C-e>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.keymap.set("i", "<C-d>", 'copilot#Dismiss("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true
