return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    enabled = not vim.g.started_by_firenvim,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
