local colorscheme = vim.g.colors_name

local M = {}

---@param highlights table<table<string, table>>
local set_highlights = function(highlights)
  for _, highlight in ipairs(highlights) do
    local group = highlight[1]
    local options = highlight[2]
    vim.api.nvim_set_hl(0, group, options)
  end
end

local function apply_custom_highlights(background)
  local custom_highlights = {}

  -- global changes for dark themes
  if background == "dark" then
    -- grey italic comments
    table.insert(custom_highlights, { "Comment", { italic = true, fg = "#555555" } })
    -- make diff highlights more visible
    table.insert(custom_highlights, { "DiffAdd", { bold = true, ctermbg = 4, fg = "#1E1E2E", bg = "#A6E3A1" } })
    table.insert(custom_highlights, { "DiffChange", { bold = true, ctermbg = 5, fg = "#1E1E2E", bg = "#F9E2AF" } })
    table.insert(
      custom_highlights,
      { "DiffDelete", { bold = true, ctermfg = 12, ctermbg = 6, fg = "#1E1E2E", bg = "#F38BA8" } }
    )
    table.insert(custom_highlights, { "DiffText", { reverse = true, ctermbg = 9, fg = "#1E1E2E", bg = "#89B4FA" } })
    -- make cursorline more visible
    -- table.insert(custom_highlights, { "CursorLine", { bg = "#3f2334" } })
    table.insert(custom_highlights, { "CursorLine", { bg = "#2e1c1c" } })
  end

  -- more nuances for dogrun
  if colorscheme == "dogrun" then
    table.insert(custom_highlights, { "@constructor", { link = "@type" } })
    table.insert(custom_highlights, { "CmpItemKindText", { link = "@text" } })
    table.insert(custom_highlights, { "CmpItemKindKeyword", { link = "@keyword" } })
    table.insert(custom_highlights, { "CmpItemKindModule", { link = "@type" } })
    table.insert(custom_highlights, { "CmpItemKindFunction", { link = "@text.literal" } })
    table.insert(custom_highlights, { "CmpItemKindVariable", { link = "@text.reference" } })
  end

  -- change grey status bar and winbars for vague
  if colorscheme == "vague" then
    local vague_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    local custom_color_dark = "#242437"
    local custom_color_light = "#9A9AbE"
    table.insert(custom_highlights, { "StatusLine", { bg = "#282830" } })
    table.insert(custom_highlights, { "lualine_c_normal", { bg = "#282830" } })
    table.insert(custom_highlights, { "lualine_c_insert", { bg = "#282830" } })
    table.insert(custom_highlights, { "lualine_c_visual", { bg = "#282830" } })
    table.insert(custom_highlights, { "lualine_c_replace", { bg = "#282830" } })
    table.insert(custom_highlights, { "lualine_c_command", { bg = "#282830" } })
    table.insert(custom_highlights, { "lualine_c_inactive", { bg = "#282830" } })
    table.insert(custom_highlights, { "lualine_c_terminal", { bg = "#282830" } })
    table.insert(custom_highlights, { "TelescopeBorder", { bg = vague_bg, fg = custom_color_light } })
    table.insert(custom_highlights, { "NeoTreeWinSeparator", { bg = vague_bg, fg = custom_color_light } })
    table.insert(custom_highlights, { "WinSeparator", { bg = vague_bg, fg = custom_color_light } })
    table.insert(custom_highlights, { "CmpItemKindText", { link = "@function" } })
    table.insert(custom_highlights, { "CmpItemKindKeyword", { link = "@constant" } })
    table.insert(custom_highlights, { "CmpItemKindModule", { link = "@attribute" } })
    table.insert(custom_highlights, { "CmpItemKindFunction", { link = "@character" } })
    table.insert(custom_highlights, { "CmpItemKindVariable", { link = "@diff.plus" } })
  end

  if background == "light" then
    if colorscheme == "solarized8_flat" then
      local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
      table.insert(custom_highlights, { "StatusLine", { bg = bg } })
      table.insert(custom_highlights, { "lualine_c_normal", { bg = bg } })
      table.insert(custom_highlights, { "lualine_c_insert", { bg = bg } })
      table.insert(custom_highlights, { "lualine_c_visual", { bg = bg } })
      table.insert(custom_highlights, { "lualine_c_replace", { bg = bg } })
      table.insert(custom_highlights, { "lualine_c_command", { bg = bg } })
      table.insert(custom_highlights, { "lualine_c_inactive", { bg = bg } })
      table.insert(custom_highlights, { "lualine_c_terminal", { bg = bg } })
    end
  end

  set_highlights(custom_highlights)

  -- require("lualine").setup({ options = { theme = "auto" } })
end

M.apply = apply_custom_highlights

return M
