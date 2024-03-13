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
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "auto",      -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true,        -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },

      highlight_groups = {
        Comment = { italic = true },
        -- VertSplit = { fg = "muted", bg = "muted" },
      },

      before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
      end,
    }
  }
}
