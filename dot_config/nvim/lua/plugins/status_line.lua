return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        -- theme = dogrun,
        component_separators = "|",
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = {
          statusline = {},
          winbar = { "toggleterm", "neo-tree" },
        },
      },
      extensions = { "fugitive" },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          "mode",
          "branch",
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
          },
          "vim.fn.getcwd()",
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
          "encoding",
          "fileformat",
          "filetype",
          {
            function()
              local msg = 'LSP-Off'
              local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            -- icon = ' LSP:',
            -- color = { fg = '#ffffff', gui = 'bold' },
          },
          "progress",
          "location"
        },
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          { "filename", path = 1, separator = "" },
          { "diff" },
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
    },
  },
}
