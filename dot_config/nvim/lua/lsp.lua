local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover({
    border = "single",
    max_width = math.floor(vim.o.columns * 0.7),
    max_height = math.floor(vim.o.lines * 0.7),
  })
end
