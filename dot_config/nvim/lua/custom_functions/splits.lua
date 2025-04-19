local M = {}

local function clear_all_splits()
  vim.cmd("only")
end

--- Split the current window vertically into three windows with provided widths.
---
--- Falls back to the following layout:
---
--- | 30% | 40% | 30% |
---
function M.three_way_split(left_width, right_width)
  clear_all_splits()

  local total_width = vim.o.columns
  local left_width = left_width or 31
  local right_width = right_width or 31

  left_width = math.floor(total_width * left_width / 100)
  right_width = math.floor(total_width * right_width / 100)

  -- split three-way
  -- |-----|-----|-----|
  vim.cmd("vsplit | vsplit")

  -- resize windows
  vim.cmd("wincmd h | wincmd h | vertical resize " .. left_width)
  vim.cmd("wincmd l | wincmd l | vertical resize " .. right_width)

  -- move to the middle window
  vim.cmd("wincmd h")
end

return M
