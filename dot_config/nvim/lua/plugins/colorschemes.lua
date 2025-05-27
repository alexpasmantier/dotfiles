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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        color_overrides = {
          mocha = {
            base = "#1a1a2a",
            -- base = "#040404",
          },
        },
        highlight_overrides = {
          mocha = function(C)
            return {
              TabLineSel = { bg = C.pink },
              CmpBorder = { fg = C.surface2 },
              Pmenu = { bg = C.none },
              TelescopeBorder = { link = "FloatBorder" },
            }
          end,
        },
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    },
  },
  "shaunsingh/nord.nvim",
  "Mofiqul/dracula.nvim",
  -- "altercation/vim-colors-solarized",
  { "lifepillar/vim-solarized8", branch = "neovim" },
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
      variant = "auto", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
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
    },
  },
  { "gremble0/yellowbeans.nvim" },
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("colorbuddy").colorscheme("gruvbuddy_helix")
    --
    --   local colorbuddy = require("colorbuddy")
    --   local Color = colorbuddy.Color
    --   local Group = colorbuddy.Group
    --   local c = colorbuddy.colors
    --   local g = colorbuddy.groups
    --   local s = colorbuddy.styles
    --
    --   Color.new("white", "#f2e5bc")
    --   Color.new("red", "#cc6666")
    --   Color.new("pink", "#fef601")
    --   Color.new("green", "#99cc99")
    --   Color.new("yellow", "#f8fe7a")
    --   Color.new("blue", "#81a2be")
    --   Color.new("aqua", "#8ec07c")
    --   Color.new("cyan", "#8abeb7")
    --   Color.new("purple", "#8e6fbd")
    --   Color.new("violet", "#b294bb")
    --   Color.new("orange", "#de935f")
    --   Color.new("brown", "#a3685a")
    --
    --   Color.new("seagreen", "#698b69")
    --   Color.new("turquoise", "#698b69")
    --
    --   local background_string = "#3b224c"
    --   Color.new("background", background_string)
    --   Color.new("gray0", background_string)
    --
    --   Group.new("Normal", c.superwhite, c.gray0)
    --
    --   Group.new("@constant", c.orange, nil, s.none)
    --   Group.new("@function", c.yellow, nil, s.none)
    --   Group.new("@function.bracket", g.Normal, g.Normal)
    --   Group.new("@keyword", c.violet, nil, s.none)
    --   Group.new("@keyword.faded", g.nontext.fg:light(), nil, s.none)
    --   Group.new("@property", c.blue)
    --   Group.new("@variable", c.superwhite, nil)
    --   Group.new("@variable.builtin", c.purple:light():light(), g.Normal)
    --
    --   -- I've always liked lua function calls to be blue. I don't know why.
    --   Group.new("@function.call.lua", c.blue:dark(), nil, nil)
    --
    --   vim.cmd.colorscheme("gruvbuddy_helix")
    -- end,
  },
  { "oneslash/helix-nvim", version = "*" },
  {
    "vague2k/vague.nvim",
    config = function()
      require("vague").setup({
        transparent = false, -- don't set background
        style = {
          -- "none" is the same thing as default. But "italic" and "bold" are also valid options
          boolean = "bold",
          number = "none",
          float = "none",
          error = "bold",
          comments = "italic",
          conditionals = "none",
          functions = "none",
          headings = "bold",
          operators = "none",
          strings = "italic",
          variables = "none",

          -- keywords
          keywords = "none",
          keyword_return = "italic",
          keywords_loop = "none",
          keywords_label = "none",
          keywords_exception = "none",

          -- builtin
          builtin_constants = "bold",
          builtin_functions = "none",
          builtin_types = "bold",
          builtin_variables = "none",
        },
        -- plugin styles where applicable
        -- make an issue/pr if you'd like to see more styling options!
        plugins = {
          cmp = {
            match = "bold",
            match_fuzzy = "bold",
          },
          dashboard = {
            footer = "italic",
          },
          lsp = {
            diagnostic_error = "bold",
            diagnostic_hint = "none",
            diagnostic_info = "italic",
            diagnostic_warn = "bold",
          },
          neotest = {
            focused = "bold",
            adapter_name = "bold",
          },
          telescope = {
            match = "bold",
          },
        },

        -- Override highlights or add new highlights
        on_highlights = function(highlights, colors) end,

        -- Override colors
        colors = {
          bg = "#241f31",
          fg = "#cdcdcd",
          floatBorder = "#878787",
          line = "#252530",
          comment = "#606079",
          builtin = "#b4d4cf",
          func = "#c48282",
          string = "#e8b589",
          number = "#e0a363",
          property = "#c3c3d5",
          constant = "#aeaed1",
          parameter = "#bb9dbd",
          visual = "#333738",
          error = "#d8647e",
          warning = "#f3be7c",
          hint = "#7e98e8",
          operator = "#90a0b5",
          keyword = "#6e94b2",
          type = "#9bb4bc",
          search = "#405065",
          plus = "#7fa563",
          delta = "#f3be7c",
        },
      })
    end,
  },
  {
    "jesseleite/nvim-noirbuddy",
    dependencies = {
      { "tjdevries/colorbuddy.nvim" },
    },
    lazy = false,
    priority = 1000,
    opts = {
      -- All of your `setup(opts)` will go here
    },
  },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = {} },
  { "norcalli/nvim-colorizer.lua" },
  -- Lua
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.cmd.colorscheme(require("options").dark_colorscheme)
        -- if lualine is loaded, update the colorscheme
        if pcall(require, "lualine") then
          require("lualine").setup()
        end
        require("custom_highlights").apply(vim.o.background)
      end,
      set_light_mode = function()
        vim.cmd.colorscheme(require("options").light_colorscheme)
        -- if lualine is loaded, update the colorscheme
        if pcall(require, "lualine") then
          require("lualine").setup()
        end
        require("custom_highlights").apply(vim.o.background)
      end,
      update_interval = 3000,
      fallback = "dark",
    },
  },
}
