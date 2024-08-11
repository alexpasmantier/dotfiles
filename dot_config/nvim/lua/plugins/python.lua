return {
  {
    dir = "/Users/alex/code/lua/pymple.nvim/",
    name = "pymple.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      update_imports = {
        filetypes = {
          "python",
          "markdown",
        },
      },
      logging = {
        enabled = true,
        file = {
          enabled = true,
          path = vim.fn.stdpath("data") .. "/pymple.vlog",
          max_lines = 1000,
        },
        console = {
          enabled = false,
        },
        level = "debug",
      },
    },
  },
}
