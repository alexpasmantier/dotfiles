return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufEnter", "VeryLazy" },
    config = function()
      local opts = {
        highlight = { enable = true },
        auto_install = true,
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "c",
          "html",
          "javascript",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-m>",
            node_incremental = "<C-m>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      }

      if type(opts.ensure_installed) == "table" then
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(vim.tbl_extend("force", opts, {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ["@function.inner"] = "V",
              ["@function.outer"] = "V",
              ["@class.outer"] = "V",
              ["@class.inner"] = "V",
            },
            include_surrounding_whitespace = false,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]]"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            },
            goto_previous_start = {
              ["[["] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
            },
          },
        },
      }))
    end,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/playground",
}
