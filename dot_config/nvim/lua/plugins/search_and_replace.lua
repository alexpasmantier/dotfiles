return {

  {
    "nvim-pack/nvim-spectre",
    opts = {
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
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local project_actions = require("telescope._extensions.project.actions")
      local telescope_layout_opts = {
        bottom_pane = {
          height = 40,
          preview_cutoff = 120,
          prompt_position = "bottom",
        },
      }
      local custom_functions = require("custom_functions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,

              ["<esc>"] = actions.close,

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

              -- ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              -- ["<C-]>"] = actions.smart_send_to_qflist,
              -- ["<C-c>"] = actions.edit_command_line,
              -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        pickers = {
          buffers = {
            theme = "ivy",
          },
          command_history = {
            theme = "ivy",
          },
          live_grep = {
            theme = "ivy",
            layout_config = telescope_layout_opts,
          },
          grep_string = {
            theme = "ivy",
            layout_config = telescope_layout_opts,
          },
          quickfix = {
            theme = "ivy",
          },
          lsp_references = {
            theme = "ivy",
          },
          lsp_document_symbols = {
            theme = "ivy",
          },
          lsp_dynamic_workspace_symbols = {
            theme = "ivy",
          },
          lsp_definitions = {
            theme = "ivy",
          },
          lsp_implementations = {
            theme = "ivy",
          },
          lsp_type_definitions = {
            theme = "ivy",
          },
          lsp_workspace_symbols = {
            theme = "ivy",
          },
          diagnostics = {
            theme = "ivy",
          },
          find_files = { -- Search ALL files, even if not tracked by git
            find_command = { "rg", "--files", "--hidden" },
            theme = "ivy",
            layout_config = telescope_layout_opts,
          },
          git_files = {
            -- find_command = { "rg", "--files", "--hidden", },
            theme = "ivy",
            layout_config = telescope_layout_opts,
          },
          colorscheme = {
            theme = "ivy",
            layout_config = telescope_layout_opts,
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
          project = {
            base_dirs = {
              "~/",
            },
            hidden_files = true, -- default: false
            theme = "ivy",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = false, -- default false
            -- default for on_project_selected = find project files
            on_project_selected = function(prompt_bufnr)
              -- Do anything you want in here. For example:
              project_actions.change_working_directory(prompt_bufnr, false)
              custom_functions.project_files()
              -- require("harpoon.ui").nav_file(1)
            end,
          },
        },
      })
    end,
  },
  "nvim-telescope/telescope-fzf-native.nvim",
  "nvim-telescope/telescope-project.nvim",
}
