return {
  -- Linting
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        markdown = { "vale" },
        python = { "ruff" },
        rust = { "rust_analyzer" },
      }
    end,
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "ruff_fix", "ruff_format" },
          -- python = { "isort", "black" },
          -- Use a sub-list to run only the first available formatter
          javascript = { { "prettierd", "prettier" } },
          terraform = { "terraform_fmt" },
          rust = { "rustfmt" },
          cpp = { "clang-format" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
  -- Goto definition preview
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({
        width = 120,              -- Width of the floating window
        height = 25,              -- Height of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false,            -- Print debug information
        opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = function(buffer, window)
          vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true, noremap = true })
        end, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
      })
    end,
  },

  -- LSP outline
  { "stevearc/aerial.nvim", config = true },
}
