return {
  -- {
  --   "folke/persistence.nvim",
  --   enabled = not vim.g.started_by_firenvim,
  --   config = function()
  --     require("persistence").setup({
  --       dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
  --       options = { "buffers", "curdir", "tabpages", "winsize" },
  --     })
  --   end,
  -- },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        pre_save_cmds = {
          "Neotree close",
        },
      })
    end,
  },
}
