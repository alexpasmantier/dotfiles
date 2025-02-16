-- KILL THE CURRENT BUFFER
local function buf_kill(kill_command, bufnr, force)
  kill_command = kill_command or "bd"

  local bo = vim.bo
  local api = vim.api
  local fmt = string.format
  local fnamemodify = vim.fn.fnamemodify

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  local bufname = api.nvim_buf_get_name(bufnr)

  if not force then
    local warning
    if bo[bufnr].modified then
      warning = fmt([[No write since last change for (%s)]], fnamemodify(bufname, ":t"))
    elseif api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
      warning = fmt([[Terminal %s will be killed]], bufname)
    end
    if warning then
      vim.ui.input({
        prompt = string.format([[%s. Close it anyway? [y]es or [n]o (default: no): ]], warning),
      }, function(choice)
        if choice ~= nil and choice:match("ye?s?") then
          buf_kill(kill_command, bufnr, true)
        end
      end)
      return
    end
  end

  -- Get list of windows IDs with the buffer to close
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  if force then
    kill_command = kill_command .. "!"
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- If there is only one buffer (which has to be the current one), vim will
  -- create a new buffer on :bd.
  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 and #windows > 0 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and #buffers or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(string.format("%s %d", kill_command, bufnr))
  end
end

vim.api.nvim_create_user_command("BufferKill", function()
  buf_kill("bd")
end, { force = true })

----------------------------------------------------------------------------------------------

-- CREATE TEST FILE FOR CURRENT FILE
-- TODO: finish this (is there some sort of path manipulation lib in lua?)
local function create_test_file_for_current_file(bufnr)
  local Path = require("plenary.path")
  local filetype = require("plenary.filetype")
  local api = vim.api

  -- get current file path and filetype
  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end
  local current_file_path = Path:new(api.nvim_buf_get_name(bufnr))
  local current_filetype = filetype.detect(current_file_path, {})
  local sep = Path.path.sep

  -- construct the path to the test file
  vim.fn.jobstart({ "git", "rev-parse", "--show-toplevel" }, {
    cwd = vim.fn.getcwd(),
    stdout_buffered = true,
    on_stdout = function(_, data)
      -- current git directory
      local current_git_dir = data[1]
      local relative_file_path = current_file_path:make_relative(current_git_dir)

      local rel_path_components = vim.split(tostring(relative_file_path), sep)
      local test_folder_path =
        Path:new("tests", table.concat(vim.list_slice(rel_path_components, 2, #rel_path_components - 1), sep))
      local test_file_path = test_folder_path:joinpath("test_" .. rel_path_components[#rel_path_components])

      -- if file doesn't exist yet, mkdir -p and touch it
      if not test_file_path:exists() then
        test_file_path:touch({ parents = true })

        if current_filetype == "python" then
          -- create any missing __init__.py files
          local dirs = vim.split(tostring(test_file_path:parent():make_relative(current_git_dir)), sep)
          local processed = ""
          for _, dir in ipairs(dirs) do
            if dir ~= "" then
              local joined = table.concat({ processed, dir }, sep)
              local init_file_path = Path:new(current_git_dir, joined, "__init__.py")
              if not init_file_path:exists() then
                init_file_path:touch()
              end
              processed = joined
            end
          end
        end
      end
      -- TODO: open the file in a new split
      -- vim.cmd.new()
    end,
  })

  -- vim.print(bufname)
end

vim.api.nvim_create_user_command("CreateTestFile", function()
  create_test_file_for_current_file()
end, { force = true })

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

----------------------------------------------------------------------------------------------
-- FULL WIDTH SPLIT

-- vim.api.nvim_create_user_command("FullWidthSplit", function()
--   vim.cmd("vnew")
--   vim.cmd.normal(vim.api.nvim_replace_termcodes("<C-w>J", true, true, true))
--   vim.cmd("resize 30")
-- end, { force = true })

----------------------------------------------------------------------------------------------

-- TELEVISION
vim.api.nvim_create_user_command("Tv", function()
  require("custom_functions.television").show()
end, { force = true })
