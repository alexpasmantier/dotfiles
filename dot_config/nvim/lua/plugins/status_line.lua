return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = not vim.g.started_by_firenvim,
    opts = {
      options = {
        theme = "auto",
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
          "vim.fn.fnamemodify(vim.fn.getcwd(), ':t')",
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
          {
            "filetype",
          },
          {
            function()
              local msg = "LSP-Off"
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return msg
              end
              local displayed_clients = {}
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  vim.list_extend(displayed_clients, { client.name })
                end
              end
              if #displayed_clients > 0 then
                return table.concat(displayed_clients, ", ")
              end
              return msg
            end,
            color = {
              fg = "#f4d88c",
              gui = "bold",
            },
          },
          "progress",
          "location",
        },
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_c = { { "filename", path = 1, separator = "", shorting_target = 40 } },
      },

      inactive_winbar = {
        lualine_c = { { "filename", path = 1, separator = "", shorting_target = 40 } },
      },
    },
  },
}
