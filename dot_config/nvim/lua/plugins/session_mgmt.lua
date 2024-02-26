return {
  {
    "folke/persistence.nvim",
    enabled = not vim.g.started_by_firenvim,
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      })
    end,
  },
}
