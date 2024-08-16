local colorscheme = vim.g.colors_name

---@param highlights table<table<string, table>>
local set_highlights = function(highlights)
  for _, highlight in ipairs(highlights) do
    local group = highlight[1]
    local options = highlight[2]
    vim.api.nvim_set_hl(0, group, options)
  end
end

local custom_highlights = {}

-- global changes for dark themes
if vim.o.background == "dark" then
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
  table.insert(custom_highlights, { "CursorLine", { bg = "#3f2334" } })
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

set_highlights(custom_highlights)
