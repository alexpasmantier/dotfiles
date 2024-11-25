return {
  {
    "alexpasmantier/pymple.nvim",
    -- dir = "~/code/lua/pymple.nvim/",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- optional (nicer ui)
      "stevearc/dressing.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    build = ":PympleBuild",
    config = function()
      require("pymple").setup({
        -- options for the update imports feature
        update_imports = {
          -- the filetypes on which to run the update imports command
          -- NOTE: this should at least include "python" for the plugin to
          -- actually do anything useful
          filetypes = { "python", "markdown" },
        },
        -- options for the add import for symbol under cursor feature
        add_import_to_buf = {
          -- whether to autosave the buffer after adding the import (which will
          -- automatically format/sort the imports if you have on-save autocommands)
          autosave = true,
        },
        -- automatically register the following keymaps on plugin setup
        keymaps = {
          -- Resolves import for symbol under cursor.
          -- This will automatically find and add the corresponding import to
          -- the top of the file (below any existing doctsring)
          resolve_import_under_cursor = {
            desc = "Resolve import under cursor",
            keys = "<leader>li", -- feel free to change this to whatever you like
          },
        },
        -- logging options
        logging = {
          -- whether to log to the neovim console (only use this for debugging
          -- as it might quickly ruin your neovim experience)
          console = {
            enabled = false,
          },
          -- whether or not to log to a file (default location is nvim's
          -- stdpath("data")/pymple.vlog which will typically be at
          -- `~/.local/share/nvim/pymple.vlog` on unix systems)
          file = {
            enabled = true,
            -- the maximum number of lines to keep in the log file (pymple will
            -- automatically manage this for you so you don't have to worry about
            -- the log file getting too big)
            max_lines = 200,
          },
          -- the log level to use
          -- (one of "trace", "debug", "info", "warn", "error", "fatal")
          level = "trace",
        },
        -- python options
        python = {
          -- the names of root markers to look out for when discovering a project
          root_markers = { "pyproject.toml", "setup.py", ".git", "manage.py" },
          -- the names of virtual environment folders to look out for when
          -- discovering a project
          virtual_env_names = { ".venv" },
        },
      })
    end,
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
