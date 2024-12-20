return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "lukas-reineke/cmp-rg",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup({
        ---@diagnostic disable-next-line: missing-fields
        completion = {
          completeopt = "menu,menuone,noinsert,noselect,preview",
        },
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "lazydev", group_index = 0 },
          { name = "nvim_lsp_signature_help", priority = 100 },
          { name = "nvim_lsp", priority = 100 },
          { name = "luasnip", priority = 8 },
          { name = "hrsh7th/cmp-nvim-lua", priority = 7 },
          { name = "buffer", priority = 6, keyword_length = 3 },
          { name = "path", priority = 4, keyword_length = 3 },
          { name = "rg", priority = 2 },
        }),
        -- sorting = defaults.sorting,
      })
    end,
  },
  {
    "gelguy/wilder.nvim",
    dependencies = {
      "romgrk/fzy-lua-native",
    },
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })
      -- Disable Python remote plugin
      wilder.set_option("use_python_remote_plugin", 0)

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          wilder.vim_search_pipeline()
        ),
      })

      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = wilder.popupmenu_renderer({
            highlighter = wilder.lua_fzy_highlighter(),
            left = {
              " ",
              wilder.popupmenu_devicons(),
            },
            right = {
              " ",
              wilder.popupmenu_scrollbar(),
            },
          }),
          ["/"] = wilder.wildmenu_renderer({
            highlighter = wilder.lua_fzy_highlighter(),
          }),
        })
      )
    end,
  },
}
