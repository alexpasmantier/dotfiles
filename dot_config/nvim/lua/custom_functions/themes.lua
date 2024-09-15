local M = {}

M.current = "dark"

local function toggle_light_theme()
  vim.o.background = "light"
  R("options")
end

local function toggle_dark_theme()
  vim.o.background = "dark"
  R("options")
end

function M.toggle()
  if M.current == "dark" then
    toggle_light_theme()
    M.current = "light"
  else
    toggle_dark_theme()
    M.current = "dark"
  end
end

return M
