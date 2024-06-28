local icons = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "󰌵",
}

local config = {
  virtual_text = false,
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  signs = {
    text = icons,
  },
}
vim.diagnostic.config(config)
vim.lsp.diagnostics_config = config

vim.fn.sign_define(
  "DiagnosticSignError",
  { text = icons[vim.diagnostic.severity.ERROR], texthl = "DiagnosticSignError" }
)
vim.fn.sign_define("DiagnosticSignWarn", { text = icons[vim.diagnostic.severity.WARN], texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = icons[vim.diagnostic.severity.INFO], texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = icons[vim.diagnostic.severity.HINT], texthl = "DiagnosticSignHint" })
