return {
  -- Linting
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        markdown = { "vale" },
        python = { "ruff", "mypy" },
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
          c = { "clang-format" },
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "ruff_fix", "ruff_format" },
          -- python = { "isort", "black" },
          -- Use a sub-list to run only the first available formatter
          javascript = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          terraform = { "terraform_fmt" },
          rust = { "rustfmt" },
          cpp = { "clang-format" },
          toml = { "taplo" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}
