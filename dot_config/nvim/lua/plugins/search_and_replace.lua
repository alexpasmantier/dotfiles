return {

  { "nvim-pack/nvim-spectre", opts = {
    open_cmd = "noswapfile vnew",
  } },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local project_actions = require("telescope._extensions.project.actions")
      local telescope_layout_opts = {
        bottom_pane = {
          height = 70,
          preview_cutoff = 120,
          prompt_position = "top",
        },
      }
      local function project_files()
        local telescope_options = {} -- define here if you want to define something
        vim.fn.system("git rev-parse --is-inside-work-tree")
        if vim.v.shell_error == 0 then
          require("telescope.builtin").git_files(telescope_options)
        else
          require("telescope.builtin").find_files(telescope_options)
        end
      end

      local function colorschemes_with_preview()
        local telescope_options = { enable_preview = true }
        require("telescope.builtin").colorscheme(telescope_options)
      end

      local function open_projects()
        require("telescope").extensions.project.project({ display_type = "full" })
      end

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
              project_files()
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
