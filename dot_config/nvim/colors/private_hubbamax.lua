-- Name:         habamax
-- Description:  Hubba hubba hubba.
-- Author:       Maxim Kim <habamax@gmail.com>
-- Maintainer:   Maxim Kim <habamax@gmail.com>
-- Website:      https://github.com/vim/colorschemes
-- License:      Same as Vim
-- Last Change:  2025 Jan 07
-- Ported to Lua: 2025 Dec 07

-- Reset to Vim defaults
vim.cmd("source $VIMRUNTIME/colors/vim.lua")

-- Set colorscheme name and background
vim.g.colors_name = "hubbamax"
vim.o.background = "dark"

-- Terminal colors
if vim.fn.has("termguicolors") == 1 and vim.o.termguicolors or vim.fn.has("gui_running") == 1 then
  local terminal_colors = {
    "#1c1c1c",
    "#af5f5f",
    "#5faf5f",
    "#af875f",
    "#5f87af",
    "#af87af",
    "#5f8787",
    "#9e9e9e",
    "#767676",
    "#d75f87",
    "#87d787",
    "#d7af87",
    "#5fafd7",
    "#d787d7",
    "#87afaf",
    "#bcbcbc",
  }

  vim.g.terminal_ansi_colors = terminal_colors

  -- Neovim uses g:terminal_color_{0-15}
  for i = 0, 15 do
    vim.g["terminal_color_" .. i] = terminal_colors[i + 1]
  end
end

-- Helper function to set highlight
local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Highlight links
local links = {
  Terminal = "Normal",
  StatuslineTerm = "Statusline",
  StatuslineTermNC = "StatuslineNC",
  MessageWindow = "Pmenu",
  PopupSelected = "PmenuSel",
  javaScriptFunction = "Statement",
  javaScriptIdentifier = "Statement",
  sqlKeyword = "Statement",
  yamlBlockMappingKey = "Statement",
  rubyMacro = "Statement",
  rubyDefine = "Statement",
  vimVar = "Normal",
  vimOper = "Normal",
  vimSep = "Normal",
  vimParenSep = "Normal",
  vimCommentString = "Comment",
  markdownUrl = "String",
}

for from, to in pairs(links) do
  hi(from, { link = to })
end

-- Main highlight groups (GUI/true color)
hi("Normal", { fg = "#bcbcbc", bg = "#1c1c1c", ctermfg = 250, ctermbg = 234 })
hi("Statusline", { fg = "#1c1c1c", bg = "#9e9e9e", ctermfg = 234, ctermbg = 247 })
hi("StatuslineNC", { fg = "#1c1c1c", bg = "#767676", ctermfg = 234, ctermbg = 243 })
hi("VertSplit", { fg = "#767676", bg = "#1c1c1c", ctermfg = 243, ctermbg = 234 })
hi("TabLine", { fg = "#1c1c1c", bg = "#767676", ctermfg = 234, ctermbg = 243 })
hi("TabLineFill", { fg = "#1c1c1c", bg = "#767676", ctermfg = 234, ctermbg = 243 })
hi("TabLineSel", { fg = "#1c1c1c", bg = "#9e9e9e", bold = true, ctermfg = 234, ctermbg = 247, cterm = { bold = true } })
hi("ToolbarLine", {})
hi("ToolbarButton", {
  fg = "#767676",
  bg = "#1c1c1c",
  bold = true,
  reverse = true,
  ctermfg = 243,
  ctermbg = 234,
  cterm = { bold = true, reverse = true },
})
hi("QuickFixLine", { bg = "#5f87af", ctermfg = 234, ctermbg = 67 })
hi("CursorLineNr", { fg = "#dadada", bold = true, ctermfg = 253, cterm = { bold = true } })
hi("LineNr", { fg = "#585858", ctermfg = 240 })
hi("LineNrAbove", { fg = "#585858", ctermfg = 240 })
hi("LineNrBelow", { fg = "#585858", ctermfg = 240 })
hi("NonText", { fg = "#585858", ctermfg = 240 })
hi("EndOfBuffer", { fg = "#585858", ctermfg = 240 })
hi("SpecialKey", { fg = "#585858", ctermfg = 240 })
hi("FoldColumn", { fg = "#585858", ctermfg = 240 })
hi(
  "Visual",
  { fg = "#87afaf", bg = "#1c1c1c", reverse = true, ctermfg = 109, ctermbg = 234, cterm = { reverse = true } }
)
hi("VisualNOS", { fg = "#1c1c1c", bg = "#5f8787", ctermfg = 234, ctermbg = 66 })
hi("Pmenu", { bg = "#1c1c1c", ctermbg = 234 })
hi("PmenuThumb", { bg = "#767676", ctermbg = 243 })
hi("PmenuSbar", {})
hi("PmenuSel", { bg = "#585858", ctermbg = 240 })
hi("PmenuKind", { fg = "#5f8787", bg = "#3a3a3a", ctermfg = 66, ctermbg = 237 })
hi("PmenuKindSel", { fg = "#5f8787", bg = "#585858", ctermfg = 66, ctermbg = 240 })
hi("PmenuExtra", { fg = "#767676", bg = "#3a3a3a", ctermfg = 243, ctermbg = 237 })
hi("PmenuExtraSel", { fg = "#9e9e9e", bg = "#585858", ctermfg = 247, ctermbg = 240 })
hi("PmenuMatch", { fg = "#ffaf5f", bg = "#3a3a3a", ctermfg = 215, ctermbg = 237 })
hi("PmenuMatchSel", { fg = "#ffaf5f", bg = "#585858", ctermfg = 215, ctermbg = 240 })
hi("SignColumn", {})
hi(
  "Error",
  { fg = "#af5f5f", bg = "#1c1c1c", reverse = true, ctermfg = 131, ctermbg = 234, cterm = { reverse = true } }
)
hi(
  "ErrorMsg",
  { fg = "#af5f5f", bg = "#1c1c1c", reverse = true, ctermfg = 131, ctermbg = 234, cterm = { reverse = true } }
)
hi("ModeMsg", { bold = true, cterm = { bold = true } })
hi("MoreMsg", { fg = "#5faf5f", ctermfg = 71 })
hi("Question", { fg = "#d7af87", ctermfg = 180 })
hi("WarningMsg", { fg = "#d75f87", ctermfg = 168 })
hi("Todo", { fg = "#dadada", bold = true, ctermfg = 253, cterm = { bold = true } })
hi("MatchParen", { fg = "#ff00af", bold = true, ctermfg = 199, cterm = { bold = true } })
hi(
  "Search",
  { fg = "#5fafd7", bg = "#1c1c1c", reverse = true, ctermfg = 74, ctermbg = 234, cterm = { reverse = true } }
)
hi(
  "IncSearch",
  { fg = "#ffaf5f", bg = "#1c1c1c", reverse = true, ctermfg = 215, ctermbg = 234, cterm = { reverse = true } }
)
hi(
  "CurSearch",
  { fg = "#ffaf5f", bg = "#1c1c1c", reverse = true, ctermfg = 215, ctermbg = 234, cterm = { reverse = true } }
)
hi("WildMenu", { fg = "#1c1c1c", bg = "#d7af87", bold = true, ctermfg = 234, ctermbg = 180, cterm = { bold = true } })
hi("debugPC", { fg = "#1c1c1c", bg = "#5f87af", ctermfg = 234, ctermbg = 67 })
hi("debugBreakpoint", { fg = "#1c1c1c", bg = "#d75f87", ctermfg = 234, ctermbg = 168 })
hi("Cursor", { fg = "#000000", bg = "#dadada" })
hi("lCursor", { fg = "#1c1c1c", bg = "#5fff00" })
hi("CursorLine", { bg = "#303030", ctermbg = 236 })
hi("CursorColumn", { bg = "#303030", ctermbg = 236 })
hi("Folded", { fg = "#9e9e9e", bg = "#262626", ctermfg = 247, ctermbg = 235 })
hi("ColorColumn", { bg = "#3a3a3a", ctermbg = 237 })
hi("SpellBad", { sp = "#d75f5f", undercurl = true, ctermfg = 167, cterm = { underline = true } })
hi("SpellCap", { sp = "#ffaf5f", undercurl = true, ctermfg = 215, cterm = { underline = true } })
hi("SpellLocal", { sp = "#5fd75f", undercurl = true, ctermfg = 77, cterm = { underline = true } })
hi("SpellRare", { sp = "#d787d7", undercurl = true, ctermfg = 176, cterm = { underline = true } })
hi("Comment", { fg = "#767676", ctermfg = 243 })
hi("Constant", { fg = "#d75f87", ctermfg = 168 })
hi("String", { fg = "#5faf5f", ctermfg = 71 })
hi("Character", { fg = "#87d787", ctermfg = 114 })
hi("Identifier", { fg = "#87afaf", ctermfg = 109 })
hi("Statement", { fg = "#af87af", ctermfg = 139 })
hi("PreProc", { fg = "#af875f", ctermfg = 137 })
hi("Type", { fg = "#5f87af", ctermfg = 67 })
hi("Special", { fg = "#5f8787", ctermfg = 66 })
hi("Underlined", { underline = true, cterm = { underline = true } })
hi("Title", { bold = true, cterm = { bold = true } })
hi("Directory", { fg = "#87afaf", bold = true, ctermfg = 109, cterm = { bold = true } })
hi("Conceal", { fg = "#585858", ctermfg = 240 })
hi("Ignore", {})
hi("Debug", { fg = "#5f8787", ctermfg = 66 })
hi("DiffAdd", { fg = "#5faf5f", reverse = true, ctermfg = 71, cterm = { reverse = true } })
hi("DiffChange", { fg = "#5f87af", reverse = true, ctermfg = 67, cterm = { reverse = true } })
hi("DiffText", { fg = "#af87af", reverse = true, ctermfg = 139, cterm = { reverse = true } })
hi("DiffDelete", { fg = "#af5f5f", reverse = true, ctermfg = 131, cterm = { reverse = true } })
hi("Added", { fg = "#5fd75f", ctermfg = 77 })
hi("Changed", { fg = "#ffaf5f", ctermfg = 215 })
hi("Removed", { fg = "#d75f5f", ctermfg = 167 })

-- vim: et ts=2 sw=2 sts=2
