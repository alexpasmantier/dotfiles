return {
  {
    dir = "/Users/alexandrepasmantier/code/lua/pymple.nvim/",
    -- "alexpasmantier/pymple.nvim",
    name = "pymple.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "stevearc/dressing.nvim",
    },
    build = ":PympleBuild",
    opts = {
      update_imports = {
        filetypes = {
          "python",
          "markdown",
        },
      },
      resolve_imports = {
        autosave = true,
      },
      logging = {
        enabled = true,
        file = {
          enabled = true,
          max_lines = 200,
        },
        level = "debug",
      },
    },
  },
  {
    dir = "~/code/lua/other.nvim/",
    name = "other-nvim",
    opts = {
      mappings = {
        "livewire",
        "angular",
        "laravel",
        "rails",
        "golang",
        "python",
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      -- "mfussenegger/nvim-dap",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    branch = "regexp", -- This is the regexp branch, use this for the new version
    config = function()
      require("venv-selector").setup()
    end,
    keys = {
      { "<leader>vv", "<cmd>VenvSelect<cr>" },
    },
  },
}
