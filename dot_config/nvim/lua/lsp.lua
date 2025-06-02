-- -- DIAGNOSTICS
-- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
--
-- local config = {
--   -- disable virtual text
--   virtual_text = false,
--   update_in_insert = false,
--   underline = true,
--   severity_sort = true,
--   float = {
--     focusable = false,
--     style = "minimal",
--     border = "rounded",
--     source = "always",
--     header = "",
--     prefix = "",
--   },
-- }
--
-- vim.diagnostic.config(config)
-- vim.lsp.diagnostics_config = config

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover({
    border = "single",
    max_width = math.floor(vim.o.columns * 0.7),
    max_height = math.floor(vim.o.lines * 0.7),
  })
end
