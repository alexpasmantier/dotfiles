local M = {}

local function get_visual_selection()
  -- Save current mode and exit visual mode to get marks
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    print("Not in visual mode")
    return ""
  end

  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("v") -- start of visual selection
  local end_pos = vim.fn.getpos(".") -- end of visual selection

  local start_row = start_pos[2]
  local start_col = start_pos[3]
  local end_row = end_pos[2]
  local end_col = end_pos[3]

  -- Ensure start is before end
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end

  -- Fetch lines from buffer
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  if #lines == 0 then
    return ""
  end

  -- Trim first and last lines to the correct columns
  lines[1] = string.sub(lines[1], start_col)
  if #lines > 1 then
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  else
    lines[1] = string.sub(lines[1], 1, end_col - start_col + 1)
  end

  return table.concat(lines, "\n")
end

M.get_visual_selection = get_visual_selection

return M
