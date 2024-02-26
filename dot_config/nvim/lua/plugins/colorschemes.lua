return {
  "folke/tokyonight.nvim",
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
  },
  "wadackel/vim-dogrun",
  "catppuccin/nvim",
  {
    "rebelot/kanagawa.nvim",
    opts = {
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    }
  },
  "shaunsingh/nord.nvim",
  "Mofiqul/dracula.nvim",
  -- "altercation/vim-colors-solarized",
  { "lifepillar/vim-solarized8", branch = 'neovim' },
  -- {
  --   "shaunsingh/solarized.nvim",
  --   config = function()
  --     require("solarized").set()
  --   end
  -- },
}
