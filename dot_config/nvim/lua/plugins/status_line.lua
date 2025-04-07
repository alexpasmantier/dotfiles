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
          {
            "filename",
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 0, -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = "[+]", -- Text to show when the file is modified.
              readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "[No Name]", -- Text to show for unnamed buffers.
              newfile = "[New]", -- Text to show for newly created file before first write
            },
          },
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
              local clients = vim.lsp.get_clients()
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
