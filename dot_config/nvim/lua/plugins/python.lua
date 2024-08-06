return {
  {
    dir = "/Users/alexandrepasmantier/code/lua/pymple.nvim/",
    name = "pymple.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "grapp-dev/nui-components.nvim",
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
        use_file = true,
        level = "trace",
      },
    },
  },
}
