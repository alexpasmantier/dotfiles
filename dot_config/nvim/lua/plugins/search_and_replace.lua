return {
  {
    "nvim-pack/nvim-spectre",
    opts = {
      is_block_ui_break = true,
      color_devicons = true,
      open_cmd = "vnew",
      live_update = true, -- auto execute search again when you write to any file in vim
      lnum_for_results = true, -- show line number for search/replace results
      line_sep_start = "┌-----------------------------------------",
      result_padding = "¦  ",
      line_sep = "└-----------------------------------------",
      highlight = {
        ui = "String",
        search = "DiffDelete",
        replace = "DiffAdd",
      },
      mapping = {
        ["toggle_line"] = {
          map = "dd",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle item",
        },
        ["enter_file"] = {
          map = "<cr>",
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = "open file",
        },
        ["send_to_qf"] = {
          map = "<leader>q",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix",
        },
        ["replace_cmd"] = {
          map = "<leader>c",
          cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
          desc = "input replace command",
        },
        ["show_option_menu"] = {
          map = "<leader>o",
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show options",
        },
        ["run_current_replace"] = {
          map = "<leader>rc",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line",
        },
        ["run_replace"] = {
          map = "<leader>R",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all",
        },
        ["change_view_mode"] = {
          map = "<leader>v",
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "change result view mode",
        },
        ["change_replace_sed"] = {
          map = "trs",
          cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
          desc = "use sed to replace",
        },
        ["change_replace_oxi"] = {
          map = "tro",
          cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
          desc = "use oxi to replace",
        },
        ["toggle_live_update"] = {
          map = "tu",
          cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
          desc = "update when vim writes to file",
        },
        ["toggle_ignore_case"] = {
          map = "ti",
          cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
          desc = "toggle ignore case",
        },
        ["toggle_ignore_hidden"] = {
          map = "th",
          cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
          desc = "toggle search hidden",
        },
        ["resume_last_search"] = {
          map = "<leader>l",
          cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
          desc = "repeat last search",
        },
        -- you can put your mapping here it only use normal mode
      },
      find_engine = {
        -- rg is map with finder_cmd
        ["rg"] = {
          cmd = "rg",
          -- default args
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
            -- you can put any rg search option you want here it can toggle with
            -- show_option function
          },
        },
        ["ag"] = {
          cmd = "ag",
          args = {
            "--vimgrep",
            "-s",
          },
          options = {
            ["ignore-case"] = {
              value = "-i",
              icon = "[I]",
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
          },
        },
      },
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = {
            "-i",
            "",
            "-E",
          },
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case",
            },
          },
        },
        -- call rust code by nvim-oxi to replace
        ["oxi"] = {
          cmd = "oxi",
          args = {},
          options = {
            ["ignore-case"] = {
              value = "i",
              icon = "[I]",
              desc = "ignore case",
            },
          },
        },
      },
      default = {
        find = {
          --pick one of item in find_engine
          cmd = "rg",
          options = { "ignore-case" },
        },
        replace = {
          --pick one of item in replace_engine
          cmd = "sed",
        },
      },
      replace_vim_cmd = "cdo",
      is_open_target_win = false, --open file on opener window
      is_insert_mode = false, -- start open panel on is_insert_mode
    },
    lazy = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          layout_config = {
            vertical = { width = 0.5 },
            horizontal = { height = 0.9, width = 0.9, preview_width = 0.5 },
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,

              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,

              -- ["<esc>"] = actions.close,

              ["<CR>"] = actions.select_default,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              -- Absolutely insane, you can refine your search
              ["<C-r>"] = actions.to_fuzzy_refine, -- in case C-space doesn't work
              -- ["<C-space>"] = actions.to_fuzzy_refine, -- already set to ctrl + space
              ["?"] = actions.which_key,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              -- trouble integration
              -- ["<C-t>"] = open_with_trouble,
            },
            n = {
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,

              ["<esc>"] = actions.close,

              ["<CR>"] = actions.select_default,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,

              -- Absolutely insane, you can refine your search
              ["<C-r>"] = actions.to_fuzzy_refine, -- in case C-space doesn't work
              -- ["<C-space>"] = actions.to_fuzzy_refine, -- already set to ctrl + space
              ["?"] = actions.which_key,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              -- trouble integration
              -- ["<C-t>"] = open_with_trouble,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    -- "alexpasmantier/tv.nvim",
    dir = "~/code/lua/tv.nvim",
    config = function()
      -- built-in niceties
      local h = require("tv").handlers

      require("tv").setup({
        -- global window appearance (can be overridden per channel)
        window = {
          width = 0.8, -- 80% of editor width
          height = 0.8, -- 80% of editor height
          border = "none",
          title = " tv.nvim ",
          title_pos = "center",
        },
        -- per-channel configurations
        channels = {
          -- `files`: fuzzy find files in your project
          files = {
            keybinding = "<C-p>", -- Launch the files channel
            -- what happens when you press a key
            handlers = {
              ["<CR>"] = h.open_as_files, -- default: open selected files
              ["<C-q>"] = h.send_to_quickfix, -- send to quickfix list
              ["<C-s>"] = h.open_in_split, -- open in horizontal split
              ["<C-v>"] = h.open_in_vsplit, -- open in vertical split
              ["<C-y>"] = h.copy_to_clipboard, -- copy paths to clipboard
            },
          },

          -- `text`: ripgrep search through file contents
          text = {
            keybinding = "<leader><leader>",
            handlers = {
              ["<CR>"] = h.open_at_line, -- Jump to line:col in file
              ["<C-q>"] = h.send_to_quickfix, -- Send matches to quickfix
              ["<C-s>"] = h.open_in_split, -- Open in horizontal split
              ["<C-v>"] = h.open_in_vsplit, -- Open in vertical split
              ["<C-y>"] = h.copy_to_clipboard, -- Copy matches to clipboard
            },
          },

          -- `git-log`: browse commit history
          ["git-log"] = {
            keybinding = "<leader>gl",
            handlers = {
              -- open commit in codediff
              ["<CR>"] = h.open_in_codediff,
              -- copy commit hash to clipboard
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- `github-prs`: browse GitHub pull requests
          ["gh-prs"] = {
            keybinding = "<leader>gpr",
            handlers = {
              -- open PR in codediff
              ["<CR>"] = function(entries, _)
                h.execute_shell_command("gh pr checkout " .. entries[1])()
                vim.cmd("Codediff main")
              end,
              -- copy commit hash to clipboard
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- `git-branch`: browse git branches
          ["git-branch"] = {
            keybinding = "<leader>gb",
            handlers = {
              -- checkout branch using execute_shell_command helper
              -- {} is replaced with the selected entry
              ["<CR>"] = h.execute_shell_command("git checkout {}"),
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          buffers = {
            keybinding = "<leader>tb",
            source = function()
              local entries = {}
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                local name = vim.api.nvim_buf_get_name(buf)
                if name ~= "" then
                  table.insert(entries, name)
                end
              end
              return entries
            end,
            preview_command = "bat -n --color=always '{}'",
            handlers = {
              ["<CR>"] = h.open_as_files,
              ["<C-q>"] = h.send_to_quickfix,
            },
          },
        },
        -- path to the tv binary (default: 'tv')
        tv_binary = "tv",
        global_keybindings = {
          channels = "<leader>tv", -- opens the channel selector
        },
        quickfix = {
          auto_open = true, -- automatically open quickfix window after populating
        },
      })
    end,
  },
}
