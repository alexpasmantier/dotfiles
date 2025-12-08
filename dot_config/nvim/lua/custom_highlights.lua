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
	-- local cursor_line = "#755375"

	-- local cursor_line = "#755375"

	-- grey italic comments
	-- table.insert(custom_highlights, { "Comment", { italic = true } })
	-- make diff highlights more visible
	-- table.insert(custom_highlights, { "DiffAdd", { bold = true, ctermbg = 4, fg = "#1E1E2E", bg = "#A6E3A1" } })
	-- table.insert(custom_highlights, { "DiffChange", { bold = true, ctermbg = 5, fg = "#1E1E2E", bg = "#F9E2AF" } })
	-- table.insert(
	--   custom_highlights,
	--   { "DiffDelete", { bold = true, ctermfg = 12, ctermbg = 6, fg = "#1E1E2E", bg = "#F38BA8" } }
	-- )
	-- table.insert(custom_highlights, { "DiffText", { reverse = true, ctermbg = 9, fg = "#1E1E2E", bg = "#89B4FA" } })
	-- make cursorline more visible
	-- table.insert(custom_highlights, { "CursorLine", { bg = "#3f2334" } })
	-- table.insert(custom_highlights, { "CursorLine", { bg = cursor_line } })
	-- if colorscheme == "habamax" then
	-- local almost_black = "#1a1a1e"
	-- local grey = "#9a9a9e"
	-- table.insert(custom_highlights, { "lualine_c_normal", { bg = almost_black, fg = grey } })
	-- table.insert(custom_highlights, { "lualine_c_insert", { bg = almost_black } })
	-- table.insert(custom_highlights, { "lualine_c_visual", { bg = almost_black } })
	-- table.insert(custom_highlights, { "lualine_c_replace", { bg = almost_black } })
	-- table.insert(custom_highlights, { "lualine_c_command", { bg = almost_black } })
	-- table.insert(custom_highlights, { "lualine_c_inactive", { bg = almost_black } })
	-- table.insert(custom_highlights, { "lualine_c_terminal", { bg = almost_black } })
	-- table.insert(custom_highlights, { "TelescopeBorder", { bg = almost_black, fg = grey } })
	-- table.insert(custom_highlights, { "NeoTreeWinSeparator", { bg = almost_black, fg = grey } })
	-- table.insert(custom_highlights, { "WinSeparator", { bg = almost_black, fg = grey } })
	-- end

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
	-- if colorscheme == "vague" then
	-- too bright I guess
	-- local vague_bg = "#241f31"
	--   local vague_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
	--   local black = "#080808"
	--   local almost_black = "#1a1a1e"
	--   local grey = "#9a9a9e"
	--   local custom_color_dark = "#242437"
	--   local custom_color_light = "#9A9AbE"
	--   local custom_lines_bg = "#282830"
	--   local custom_lines_bg_lighter = "#383840"
	--   table.insert(custom_highlights, { "Normal", { bg = vague_bg } })
	--   table.insert(custom_highlights, { "SignColumn", { bg = vague_bg } })
	--   table.insert(custom_highlights, { "StatusLine", { bg = custom_lines_bg, fg = grey } })
	--   table.insert(custom_highlights, { "Visual", { bg = cursor_line } })
	--   table.insert(custom_highlights, { "Folded", { bg = almost_black, fg = custom_lines_bg_lighter } })
	--   table.insert(custom_highlights, { "lualine_c_normal", { bg = almost_black, fg = custom_color_light } })
	--   table.insert(custom_highlights, { "lualine_c_insert", { bg = almost_black } })
	--   table.insert(custom_highlights, { "lualine_c_visual", { bg = almost_black } })
	--   table.insert(custom_highlights, { "lualine_c_replace", { bg = almost_black } })
	--   table.insert(custom_highlights, { "lualine_c_command", { bg = almost_black } })
	--   table.insert(custom_highlights, { "lualine_c_inactive", { bg = almost_black } })
	--   table.insert(custom_highlights, { "lualine_c_terminal", { bg = almost_black } })
	--   table.insert(custom_highlights, { "TelescopeBorder", { bg = vague_bg, fg = custom_color_light } })
	--   table.insert(custom_highlights, { "NeoTreeWinSeparator", { bg = vague_bg, fg = custom_lines_bg_lighter } })
	--   table.insert(custom_highlights, { "WinSeparator", { bg = vague_bg, fg = custom_lines_bg_lighter } })
	--   table.insert(custom_highlights, { "CmpItemKindText", { link = "@function" } })
	--   table.insert(custom_highlights, { "CmpItemKindKeyword", { link = "@constant" } })
	--   table.insert(custom_highlights, { "CmpItemKindModule", { link = "@attribute" } })
	--   table.insert(custom_highlights, { "CmpItemKindFunction", { link = "@character" } })
	--   table.insert(custom_highlights, { "CmpItemKindVariable", { link = "@diff.plus" } })
	-- end
	--
	-- if background == "light" then
	--   if colorscheme == "solarized8_flat" then
	--     local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
	--     table.insert(custom_highlights, { "StatusLine", { bg = bg } })
	--     table.insert(custom_highlights, { "lualine_c_normal", { bg = bg } })
	--     table.insert(custom_highlights, { "lualine_c_insert", { bg = bg } })
	--     table.insert(custom_highlights, { "lualine_c_visual", { bg = bg } })
	--     table.insert(custom_highlights, { "lualine_c_replace", { bg = bg } })
	--     table.insert(custom_highlights, { "lualine_c_command", { bg = bg } })
	--     table.insert(custom_highlights, { "lualine_c_inactive", { bg = bg } })
	--     table.insert(custom_highlights, { "lualine_c_terminal", { bg = bg } })
	--   end
	-- end
	-- vim.notify("Custom highlights: " .. vim.inspect(custom_highlights))

	set_highlights(custom_highlights)

	-- require("lualine").setup({ options = { theme = "auto" } })
end

M.apply = apply_custom_highlights

return M
