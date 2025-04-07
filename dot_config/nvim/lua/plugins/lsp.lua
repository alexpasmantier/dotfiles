return {
  { "Bilal2453/luvit-meta" },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { "williamboman/mason.nvim" }, -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" }, -- Required
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
    },
    config = function()
      local lsp = require("lsp-zero").preset({})

      lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({ buffer = bufnr })
      end)

      require("lspconfig").pyright.setup({
        settings = {
          pyright = {
            reportMissingImports = true,
            typeCheckingMode = "off",
          },
        },
      })

      require("lspconfig").rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = {
                "--",
                "--no-deps",
                "-Dclippy::correctness",
                "-Dclippy::complexity",
                "-Wclippy::perf",
                "-Wclippy::pedantic",
              },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      })

      lsp.setup()
    end,
  },
  -- Goto definition preview
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({
        width = 120, -- Width of the floating window
        height = 25, -- Height of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = function(buffer, window)
          vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true, noremap = true })
        end, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
      })
    end,
  },

  -- LSP outline
  -- {
  --   "hedyhli/outline.nvim",
  --   lazy = true,
  --   cmd = { "Outline", "OutlineOpen" },
  --   keys = { -- Example mapping to toggle outline
  --     { "<leader>lo", "<cmd>Outline<CR>", desc = "Toggle outline" },
  --   },
  --   opts = {
  --     outline_window = {
  --       split_command = "rightbelow vsplit",
  --     },
  --   },
  -- },
  -- pretty hover
  -- {
  --   "Fildo7525/pretty_hover",
  --   event = "LspAttach",
  --   opts = {},
  -- },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "bassamsdata/namu.nvim",
    config = function()
      require("namu").setup({
        -- Enable the modules you want
        namu_symbols = {
          enable = true,
          options = {}, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        colorscheme = {
          enable = false,
          options = {
            -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
            persist = true, -- very efficient mechanism to Remember selected colorscheme
            write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
          },
        },
        ui_select = { enable = false }, -- vim.ui.select() wrapper
      })
      -- === Suggested Keymaps: ===
      local namu = require("namu.namu_symbols")
      local colorscheme = require("namu.colorscheme")
      vim.keymap.set("n", "<leader>lo", ":Namu symbols<cr>", {
        desc = "Jump to LSP symbol",
        silent = true,
      })
      vim.keymap.set("n", "<leader>te", ":Namu colorscheme<cr>", {
        desc = "Colorscheme Picker",
        silent = true,
      })
    end,
  },
}
