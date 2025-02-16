local M = {}

function M.show(opts)
  opts = opts or {}

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  local height = math.ceil(vim.o.lines * 0.8)
  local width = math.ceil(vim.o.columns * 0.8)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.ceil((vim.o.lines - height) / 2),
    col = math.ceil((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_set_current_win(win)

  -- tv is an interactive fuzzy finder
  vim.fn.termopen("tv", {
    on_exit = function(_, code)
      -- read the file path from the buffer
      local paths = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

      -- P(paths)
      vim.api.nvim_win_close(win, true)

      -- open all selected files
      for _, path in ipairs(paths) do
        if path ~= "" then
          vim.cmd("edit " .. path)
        else
          break
        end
      end
    end,
    -- stdout_buffered = true,
  })

  vim.cmd.startinsert()
end

return M
