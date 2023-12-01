local module = {}


-- autopairs
require('nvim-autopairs').setup()


-- colorschemes
require('nightfox').setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
})
require('kanagawa').setup({
  colors = { theme = { all = { ui = { bg_gutter = "none", } } } }
})

-- comments
require('Comment').setup()


-- indentation
require('ibl').setup()


-- git gutter signs
require('gitsigns').setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end

    -- stylua: ignore start
    map("n", "]h", gs.next_hunk, "Next Hunk")
    map("n", "[h", gs.prev_hunk, "Prev Hunk")
    -- map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    -- map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    -- map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
    -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
    -- map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
    -- map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
    -- map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
    -- map("n", "<leader>ghd", gs.diffthis, "Diff This")
    -- map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
    -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  end,
})


-- status line
local dogrun = require("lualine_custom_themes.dogrun")
require('lualine').setup({
  options = {
    theme = "auto",
    -- theme = dogrun,
    component_separators = "|",
    globalstatus = true,
    disabled_filetypes = {
      statusline = {},
      winbar = { "toggleterm", "neo-tree" },
    },
  },
  extensions = { "neo-tree", "fugitive", "toggleterm" },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', {
      'diff',
      symbols = {
        added = " ",
        modified = " ",
        removed = " ",
      },
    } },
    lualine_c = { "vim.fn.getcwd()" },
    lualine_x = { {
      'diagnostics',
      symbols = {
        error = " ",
        warn = " ",
        info = " ",
        hint = " ",
      },
    }, 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { "filename", path = 1, separator = "" },
      { 'diff' }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },

  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { "filename", path = 1, separator = "" },
      -- {
      --   "filetype",
      --   icon_only = true,
      --   separator = "",
      --   padding = { left = 1, right = 0 },
      -- },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})


-- neorg
require('neorg').setup({
  load = {
    ["core.defaults"] = {},  -- default behaviour
    ["core.concealer"] = {}, -- pretty icons while typing
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        },
        default_workspace = "notes"
      }
    },
    ["core.export"] = {},
    ["core.summary"] = {},
    ["core.presenter"] = {
      config = { zen_mode = "zen-mode" }
    }
  },
})


-- neotree
require('neo-tree').setup({
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
  sort_case_insensitive = false,                         -- used when sorting files and directories in the tree
  sort_function = nil,                                   -- use a custom function for sorting files and directories in the tree
  -- sort_function = function (a,b)
  --       if a.type == b.type then
  --           return a.path > b.path
  --       else
  --           return a.type > b.type
  --       end
  --   end , -- this sorts files and directories descendantly
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "ﰊ",
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon",
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted = "✖", -- this can only be used in the git_status source
        renamed = "", -- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  },
  -- A list of functions, each representing a global custom command
  -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
  -- see `:h neo-tree-global-custom-commands`
  commands = {
    custom_open_with_window_picker = function(state)
      local open_windows = vim.api.nvim_list_wins()
      if #open_windows == 1 then
        require("neo-tree.sources.filesystem.commands").open(state)
      else
        require("neo-tree.sources.filesystem.commands").open_with_window_picker(state)
      end
    end
  }, -- Add a custom command or override a global one using the same function name
  window = {
    position = "left",
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "revert_preview",
      ["P"] = { "toggle_preview", config = { use_float = false } },
      ["S"] = "open_split",
      ["<C-v>"] = "open_vsplit",
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["l"] = "custom_open_with_window_picker",
      ["h"] = "close_node",
      -- ['C'] = 'close_all_subnodes',
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none", -- "none", "relative", "absolute"
        },
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = true, -- only works on Windows for hidden files/directories
      hide_by_name = {
        --"node_modules"
      },
      hide_by_pattern = { -- uses glob style patterns
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    follow_current_file = { enabled = true }, -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    group_empty_dirs = false,                 -- when true, empty folders will be grouped together
    hijack_netrw_behavior = "open_current",   -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_current",  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["I"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-j>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-k>"] = "move_cursor_up",
      },
    },
  },
  buffers = {
    follow_current_file = { enabled = true }, -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    group_empty_dirs = true,                  -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
      },
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },
})
vim.g.nvim_tree_disable_netrw = 0


-- spectre
require('spectre').setup({ open_cmd = "noswapfile vnew" })


-- telescope
local actions = require 'telescope.actions'
local project_actions = require("telescope._extensions.project.actions")
local telescope_layout_opts = {
  bottom_pane = {
    height = 70,
    preview_cutoff = 120,
    prompt_position = "top",
  },
}
function module.project_files()
  local telescope_options = {} -- define here if you want to define something
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files(telescope_options)
  else
    require "telescope.builtin".find_files(telescope_options)
  end
end

function module.colorschemes_with_preview()
  local telescope_options = { enable_preview = true }
  require "telescope.builtin".colorscheme(telescope_options)
end

function module.open_projects()
  require "telescope".extensions.project.project { display_type = 'full' }
end

require('telescope').setup({
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
      find_command = { "rg", "--files", "--hidden", },
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
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    project = {
      base_dirs = {
        '~/',
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
        module.project_files()
        -- require("harpoon.ui").nav_file(1)
      end
    },
  }
})


-- todo comments
require('todo-comments').setup()


-- treesitter
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
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
}

if type(opts.ensure_installed) == "table" then
  local added = {}
  opts.ensure_installed = vim.tbl_filter(
    function(lang)
      if added[lang] then
        return false
      end
      added[lang] = true
      return true
    end, opts.ensure_installed
  )
end
require("nvim-treesitter.configs").setup(
  vim.tbl_extend("force", opts,
    {
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
    }
  )
)

-- neodev
require("neodev").setup(
  {
    override = function(root_dir, options)
      vim.notify('Neodev with root dir ' .. root_dir, vim.log.levels.INFO)
    end
  }
)


-- lsp zero
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat()
end)

require('lspconfig').pyright.setup({
  settings = {
    pyright = {
      reportMissingImports = true,
      typeCheckingMode = 'off',
    }
  }
})

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    -- use black for python
    ['lua_ls'] = { 'lua' },
  }
})

lsp.setup()


-- linting
require('lint').linters_by_ft = {
  markdown = { 'vale', },
  python = { 'ruff', },
}

-- formatting
require('conform').setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "ruff_fix", "ruff_format" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },
    terraform = { "terraform_fmt" }
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
)


-- autocompletion
-- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
local cmp = require("cmp")
local defaults = require("cmp.config.default")()
---@diagnostic disable-next-line: missing-fields
cmp.setup({
  ---@diagnostic disable-next-line: missing-fields
  completion = {
    completeopt = "menu,menuone,noinsert,noselect,preview",
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),

  },
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<S-CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help", priority = 10 },
    { name = "nvim_lsp",                priority = 10 },
    { name = "luasnip",                 priority = 8 },
    { name = "buffer",                  priority = 6, keyword_length = 3 },
    { name = "path",                    priority = 4, keyword_length = 3 },
  }),
  sorting = defaults.sorting,
})


-- goto definition preview
require('goto-preview').setup {
  width = 120,              -- Width of the floating window
  height = 25,              -- Height of the floating window
  default_mappings = false, -- Bind default mappings
  debug = false,            -- Print debug information
  opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
  post_open_hook = function(buffer, window)
    vim.keymap.set('n', 'q', ':close<CR>', { buffer = true, silent = true, noremap = true })
  end -- A function taking two arguments, a buffer and a window to be ran as a hook.
  -- You can use "default_mappings = true" setup option
  -- Or explicitly set keybindings
}


-- lsp outline (aerial)
require('aerial').setup()


-- persistence (session management)
require("persistence").setup {
  dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
  options = { "buffers", "curdir", "tabpages", "winsize" },
}

-- flash
require("flash").setup {
  mode = function(str)
    return "\\<" .. str
  end,
}
-- additional highlight settings
vim.api.nvim_set_hl(0, 'FlashCurrent', { bg = "#f2c168", bold = true, underline = true })
vim.api.nvim_set_hl(0, 'FlashMatch', { underline = true, bold = true })
vim.api.nvim_set_hl(0, 'FlashLabel', { fg = "#f2c168", bold = true })


-- toggleterm (terminal)
require("toggleterm").setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.45
    end
  end,
  open_mapping = [[<C-\>]],
  direction = 'float',
  border = 'double',
}


-- octo PR reviews
require("octo").setup({
  default_remote = { "origin", "upstream" }, -- order to try remotes
  ui = {
    use_signcolumn = false,                  -- show "modified" marks on the sign column
  },
  mappings = {
    pull_request = {
      checkout_pr = { lhs = "<space>och", desc = "checkout PR" },
      squash_and_merge_pr = { lhs = "<space>om", desc = "squash and merge PR" },
      list_changed_files = { lhs = "<space>ols", desc = "list PR changed files" },
      show_pr_diff = { lhs = "<space>od", desc = "show PR diff" },
      close_issue = { lhs = "<space>ocl", desc = "close PR" },
      reload = { lhs = "<C-r>", desc = "reload PR" },
      open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      goto_file = { lhs = "gf", desc = "go to file" },
      add_comment = { lhs = "<space>oca", desc = "add comment" },
      delete_comment = { lhs = "<space>ocd", desc = "delete comment" },
      -- next_comment = { lhs = "]c", desc = "go to next comment" },
      -- prev_comment = { lhs = "[c", desc = "go to previous comment" },
      react_thumbs_up = { lhs = "<space>ort", desc = "add/remove 👍 reaction" },
      react_laugh = { lhs = "<space>orl", desc = "add/remove 😄 reaction" },
    },
    review_thread = {
      add_comment = { lhs = "<space>oca", desc = "add comment" },
      add_suggestion = { lhs = "<space>osa", desc = "add suggestion" },
      delete_comment = { lhs = "<space>ocd", desc = "delete comment" },
      -- next_comment = { lhs = "]c", desc = "go to next comment" },
      -- prev_comment = { lhs = "[c", desc = "go to previous comment" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      react_thumbs_up = { lhs = "<space>ort", desc = "add/remove 👍 reaction" },
      react_laugh = { lhs = "<space>orl", desc = "add/remove 😄 reaction" },
    },
    submit_win = {
      approve_review = { lhs = "<C-a>", desc = "approve review" },
      comment_review = { lhs = "<C-m>", desc = "comment review" },
      request_changes = { lhs = "<C-r>", desc = "request changes review" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    },
    review_diff = {
      add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
      add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      next_thread = { lhs = "]t", desc = "move to next thread" },
      prev_thread = { lhs = "[t", desc = "move to previous thread" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
      goto_file = { lhs = "gf", desc = "go to file" },
    },
    file_panel = {
      next_entry = { lhs = "j", desc = "move to next changed file" },
      prev_entry = { lhs = "k", desc = "move to previous changed file" },
      select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
      refresh_files = { lhs = "R", desc = "refresh changed files panel" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
    }
  }
})
-- override Octo's weird highlight color choices
vim.api.nvim_set_hl(0, 'OctoEditable', {})
-- enable markdown highlighting in octo files
vim.treesitter.language.register('markdown', 'octo')

-- which-key
require("which-key").setup {
  plugins = {
    marks = true,     -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = false,    -- adds help for operators like d, y, ...
      motions = false,      -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true,       -- default bindings on <c-w>
      nav = false,          -- misc bindings to work with windows
      z = true,             -- bindings for folds, spelling and others prefixed with z
      g = true,             -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = {},
  key_labels = {},
  motions = {
    count = true,
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  window = {
    border = "none",          -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
    padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
    zindex = 1000,            -- positive value to position WhichKey above other floating windows.
  },
  layout = {
    height = { min = 5, max = 25 },                                                 -- min and max height of the columns
    width = { min = 20, max = 50 },                                                 -- min and max width of the columns
    spacing = 3,                                                                    -- spacing between columns
    align = "center",                                                               -- align columns left, center or right
  },
  ignore_missing = false,                                                           -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
  show_help = true,                                                                 -- show a help message in the command line for using WhichKey
  show_keys = true,                                                                 -- show the currently pressed key and its label as a message in the command line
  triggers = "auto",                                                                -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specifiy a list manually
  -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
  triggers_nowait = {
    -- marks
    "`",
    "'",
    "g`",
    "g'",
    -- registers
    '"',
    "<c-r>",
    -- spelling
    "z=",
  },
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for keymaps that start with a native binding
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by default for Telescope
  disable = {
    buftypes = {},
    filetypes = {},
  },
}

return module
