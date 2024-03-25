return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = not vim.g.started_by_firenvim,
    opts = {
      options = {
        theme = "auto",
        -- theme = dogrun,
        component_separators = "|",
        section_separators = { left = "", right = "" },
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
          "filename",
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰌵 ",
            },
          },
          "encoding",
          "fileformat",
          "filetype",
          {
            function()
              local msg = "LSP-Off"
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
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
          "location",
        },
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_c = { { "filename", path = 1, separator = "" } },
      },

      inactive_winbar = {
        lualine_c = { { "filename", path = 1, separator = "" } },
      },
    },
  },
}
