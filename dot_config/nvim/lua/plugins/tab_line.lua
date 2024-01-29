return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          style_preset = bufferline.style_preset.no_italic,
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          -- style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
          themable = false, -- | false, -- allows highlight groups to be overriden i.e. sets highlights as default
          numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
          close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
          right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
          left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
          middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
          indicator = {
            -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
            style = "none", --"icon" | "underline" | "none",
          },
          max_name_length = 25,
          max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          truncate_names = false, -- whether or not tab names should be truncated
          tab_size = 18,
          diagnostics = false, -- false | "nvim_lsp" | "coc",
          -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer", -- | function ,
              text_align = "left", -- | "center" | "right"
              separator = true,
            },
          },
          color_icons = false, -- true | false, -- whether or not to add the filetype icon highlights
          show_buffer_icons = false, --true | false, -- disable filetype icons for buffers
          show_buffer_close_icons = false,
          show_close_icon = false, -- true | false,
          show_tab_indicators = false, --true | false,
          show_duplicate_prefix = true, -- | false, -- whether to show duplicate buffer prefix
          persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
          move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
          -- can also be a table containing 2 custom separators
          -- [focused and unfocused]. eg: { '|', '|' }
          separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { "any", "any" },
          enforce_regular_tabs = false, -- | true,
          always_show_bufferline = true, -- | false,
          sort_by = "insert_at_end",
          -- | "insert_after_current"
          -- | "id"
          -- | "extension"
          -- | "relative_directory"
          -- | "directory"
          -- | "tabs"
          -- | function(buffer_a, buffer_b)
          --   -- add custom logic
          --   return buffer_a.modified > buffer_b.modified
          -- end,
        },
      })
    end,
  },
}
