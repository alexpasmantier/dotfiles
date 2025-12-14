return {
  "wadackel/vim-dogrun",
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- latte, frappe, macchiato, mocha
  --       transparent_background = true,
  --       color_overrides = {
  --         mocha = {
  --           base = "#1a1a2a",
  --           -- base = "#040404",
  --         },
  --       },
  --       highlight_overrides = {
  --         mocha = function(C)
  --           return {
  --             TabLineSel = { bg = C.pink },
  --             CmpBorder = { fg = C.surface2 },
  --             Pmenu = { bg = C.none },
  --             TelescopeBorder = { link = "FloatBorder" },
  --           }
  --         end,
  --       },
  --     })
  --   end,
  -- },
  -- "shaunsingh/nord.nvim",
  { "lifepillar/vim-solarized8", branch = "neovim" },
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
          line = "#342f31",
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
  -- {
  --   "jesseleite/nvim-noirbuddy",
  --   dependencies = {
  --     { "tjdevries/colorbuddy.nvim" },
  --   },
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     -- All of your `setup(opts)` will go here
  --   },
  -- },
  -- {
  --   "slugbyte/lackluster.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = {} },
  { "norcalli/nvim-colorizer.lua" },
  -- Lua
  {
    dir = "~/code/lua/hubbamax.nvim",
    opts = { transparent_background = false },
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme(require("options").dark_colorscheme)
        -- if lualine is loaded, update the colorscheme
        -- if pcall(require, "lualine") then
        --   require("lualine").setup()
        -- end
        require("custom_highlights").apply(vim.o.background)
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme(require("options").light_colorscheme)
        -- if lualine is loaded, update the colorscheme
        -- if pcall(require, "lualine") then
        --   require("lualine").setup()
        -- end
        require("custom_highlights").apply(vim.o.background)
      end,
      update_interval = 3000,
      fallback = "dark",
    },
  },
}
