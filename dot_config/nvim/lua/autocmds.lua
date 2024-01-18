-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ LSP: map keys when server attaches to buffer]]
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- NOTE: this conflicts with window navigation
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- NOTE: I don't use these at the moment. Keep them just in case...
    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wl", function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { opts.args, desc = "Go to type definition" })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { opts.args, desc = "Lsp rename" })
    vim.keymap.set({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, { opts.args, desc = "Lsp code action" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, { opts.args, desc = "Lsp format file" })
  end,
})

-- [[ remap q to close buffers of certain filetypes ]]
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fugitive*", "help", "qf", "git", "lspinfo", "vim", "spectre_panel" },
  callback = function()
    vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true, noremap = true })
  end,
})
-- same thing but based on file names instead of filetypes
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.git/", "fugitive:/*" },
  callback = function()
    vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true, noremap = true })
  end,
})

-- [[ more remaps for fugitive buffers ]]
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fugitive" },
  callback = function()
    vim.keymap.set("n", "<leader>p", "<cmd>G push<CR>", { buffer = true, silent = true, noremap = true })
  end,
})

-- [[ Lint on Bufwrite ]]
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.py" },
  callback = function()
    require("lint").try_lint()
  end,
})
