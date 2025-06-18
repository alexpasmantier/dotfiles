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

--- Split the current window vertically into three windows with both sides having a blank buffer.
---
--- Falls back to the following layout:
---
--- | 25% | 50% | 25% |
---
function M.three_way_split_blank(left_width, right_width)
  clear_all_splits()

  local total_width = vim.o.columns
  local left_width = left_width or 25
  local right_width = right_width or 25

  left_width = math.floor(total_width * left_width / 100)
  right_width = math.floor(total_width * right_width / 100)

  -- split three-way with blank buffers
  -- |-----|-----|-----|
  vim.cmd(
    "leftabove vnew | setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted | wincmd l | rightbelow vnew | setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted | wincmd h"
  )

  -- resize windows
  vim.cmd("wincmd h | wincmd h | vertical resize " .. left_width)
  vim.cmd("wincmd l | wincmd l | vertical resize " .. right_width)

  -- move to the middle window
  vim.cmd("wincmd h")
end

return M
