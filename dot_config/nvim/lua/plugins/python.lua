return {
  {
    dir = "/Users/alexandrepasmantier/code/lua/pymple.nvim/",
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
      resolve_imports = {
        autosave = true,
      },
      logging = {
        enabled = true,
        file = {
          enabled = true,
        },
        level = "debug",
      },
    },
  },
}
