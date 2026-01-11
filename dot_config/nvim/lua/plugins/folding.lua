return {
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
      foldKeymaps = {
        hOnlyOpensOnFirstColumn = true,
      },
      autoFold = {
        enabled = false,
      },
    }, -- needed even when using default config
  },
}
