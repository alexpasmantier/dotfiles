return {
  { "Bilal2453/luvit-meta" },
  { "pest-parser/pest.vim" },
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { "mason-org/mason.nvim", opts = {} },
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
      if not lspconfig_status_ok then
        print("lspconfig not found!")
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

          -- Find references for the word under your cursor.
          map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "single", source = true, style = "minimal" },
        underline = false,
        virtual_text = false,
        update_in_insert = false,
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
          },
        } or {},
      })

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {},
        gopls = {},
        pyright = {},
        rust_analyzer = {},
        ts_ls = {},
        --

        lua_ls = {},
      }
      --
      -- local ensure_installed = vim.tbl_keys(servers or {})
      -- vim.list_extend(ensure_installed, {
      --   "stylua", -- Used to format Lua code
      -- })
      -- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      --
      -- require("mason-lspconfig").setup({
      --   ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
      --   automatic_installation = true,
      --   automatic_enable = false,
      --   handlers = {
      --     function(server_name)
      --       local server = servers[server_name] or {}
      --       require("lspconfig")[server_name].setup(server)
      --     end,
      --   },
      -- })

      -- rust-analyzer / rust_analyzer...
      lspconfig["rust_analyzer"].setup({
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy", -- Use clippy for linting
            },
          },
        },
      })

      -- pyright
      lspconfig.pyright.setup({
        settings = {
          pyright = {
            reportMissingImports = true,
            typeCheckingMode = "off",
          },
        },
      })

      -- lua_ls
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Recognize 'vim' as a global variable
            },
            workspace = {
              checkThirdParty = false, -- Disable third-party checks
            },
            telemetry = {
              enable = false, -- Disable telemetry
            },
          },
        },
      })

      -- clangd
      lspconfig.clangd.setup({
        cmd = { "clangd", "--background-index" }, -- Use clangd with background indexing
        filetypes = { "c", "cpp", "objc", "objcpp" }, -- Specify filetypes for clangd
      })

      -- gopls
      lspconfig.gopls.setup({
        cmd = { "gopls", "-remote=auto" }, -- Use gopls with remote auto-detection
        filetypes = { "go", "gomod" }, -- Specify filetypes for gopls
        settings = {
          gopls = {
            analyses = {
              unusedparams = true, -- Enable unused parameter analysis
            },
            staticcheck = true, -- Enable static check
          },
        },
      })
    end,
  },
  -- {
  --   "VonHeikemen/lsp-zero.nvim",
  --   branch = "v2.x",
  --   dependencies = {
  --     -- LSP Support
  --     { "neovim/nvim-lspconfig" }, -- Required
  --     { "williamboman/mason.nvim" }, -- Optional
  --     { "williamboman/mason-lspconfig.nvim" }, -- Optional
  --
  --     -- Autocompletion
  --     { "hrsh7th/nvim-cmp" }, -- Required
  --     { "hrsh7th/cmp-nvim-lsp" }, -- Required
  --     { "L3MON4D3/LuaSnip" }, -- Required
  --     {
  --       "j-hui/fidget.nvim",
  --       opts = {
  --         notification = {
  --           window = {
  --             winblend = 0,
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function()
  --     local lsp = require("lsp-zero").preset({})
  --
  --     lsp.on_attach(function(client, bufnr)
  --       -- see :help lsp-zero-keybindings
  --       -- to learn the available actions
  --       lsp.default_keymaps({ buffer = bufnr })
  --     end)
  --
  --     require("lspconfig").pyright.setup({
  --       settings = {
  --         pyright = {
  --           reportMissingImports = true,
  --           typeCheckingMode = "off",
  --         },
  --       },
  --     })
  --
  --     require("lspconfig").rust_analyzer.setup({
  --       settings = {
  --         ["rust-analyzer"] = {
  --           cargo = {
  --             allFeatures = true,
  --             loadOutDirsFromCheck = true,
  --             runBuildScripts = true,
  --           },
  --           -- Add clippy lints for Rust.
  --           checkOnSave = true,
  --           procMacro = {
  --             enable = true,
  --             ignored = {
  --               ["async-trait"] = { "async_trait" },
  --               ["napi-derive"] = { "napi" },
  --               ["async-recursion"] = { "async_recursion" },
  --             },
  --           },
  --         },
  --       },
  --     })
  --
  --     lsp.setup()
  --   end,
  -- },
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
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>lo", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      outline_window = {
        split_command = "rightbelow vsplit",
      },
    },
  },
  -- pretty hover
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  -- {
  --   "bassamsdata/namu.nvim",
  --   config = function()
  --     require("namu").setup({
  --       -- Enable the modules you want
  --       namu_symbols = {
  --         enable = true,
  --         options = {}, -- here you can configure namu
  --       },
  --       -- Optional: Enable other modules if needed
  --       colorscheme = {
  --         enable = false,
  --         options = {
  --           -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
  --           persist = true, -- very efficient mechanism to Remember selected colorscheme
  --           write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
  --         },
  --       },
  --       ui_select = { enable = false }, -- vim.ui.select() wrapper
  --     })
  --     -- === Suggested Keymaps: ===
  --     local namu = require("namu.namu_symbols")
  --     local colorscheme = require("namu.colorscheme")
  --     vim.keymap.set("n", "<leader>lo", ":Namu symbols<cr>", {
  --       desc = "Jump to LSP symbol",
  --       silent = true,
  --     })
  --     vim.keymap.set("n", "<leader>te", ":Namu colorscheme<cr>", {
  --       desc = "Colorscheme Picker",
  --       silent = true,
  --     })
  --   end,
  -- },
}
