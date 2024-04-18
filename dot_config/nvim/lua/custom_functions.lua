local M = {}

function M.project_files()
  local telescope_options = {} -- define here if you want to define something
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(telescope_options)
  else
    require("telescope.builtin").find_files(telescope_options)
  end
end

function M.colorschemes_with_preview()
  local telescope_options = { enable_preview = true }
  require("telescope.builtin").colorscheme(telescope_options)
end

function M.open_projects()
  require("telescope").extensions.project.project({ display_type = "full" })
end

function M.search_dotfiles()
  require("telescope.builtin").find_files({
    prompt_title = "< .config >",
    cwd = "~/.config",
  })
end

function M.search_notes()
  require("telescope.builtin").find_files({
    prompt_title = "< Notes >",
    cwd = "~/notes/",
  })
end

local IMPORT_SEPARATORS = {
  python = ".",
  rust = "::",
  lua = ".",
  typescript = "/",
  javascript = "/",
  typescriptreact = "/",
  javascriptreact = "/",
}
local DEFAULT_IMPORT_SEPARATOR = "."

local function get_import_separator(ft)
  if ft == nil then
    return DEFAULT_IMPORT_SEPARATOR
  else
    return IMPORT_SEPARATORS[ft] or DEFAULT_IMPORT_SEPARATOR
  end
end

local function truncate_str_at_last_occurence_of_char(str, char)
  local parts = string.gmatch(str, "[^" .. char .. "]+")
  local final_parts = {}
  for part in parts do
    table.insert(final_parts, part)
  end
  local final_str = table.concat(final_parts, char, 1, #final_parts - 1)
  return final_str
end

local function make_import_path(relative_file_path, import_separator)
  local path_without_suffix = truncate_str_at_last_occurence_of_char(relative_file_path, ".")
  local import_path = string.gsub(path_without_suffix, "/", import_separator)
  return import_path
end
--[[
scripts[./]load[./]international_tax_agreement[./]transform[./]const(.py)?

scripts/load/international_tax_agreement/transform/toot.py
--]]
function M.open_spectre_with_renaming(before, after)
  local Path = require("plenary.path")
  local filetype = require("plenary.filetype")
  local cwd = vim.fn.getcwd()
  local import_separator = get_import_separator(filetype.detect(before, {}))
  local relative_before = Path:new(before):make_relative(cwd)
  local relative_after = Path:new(after):make_relative(cwd)

  require("spectre").open({
    is_insert_mode = false,
    search_text = make_import_path(relative_before, import_separator),
    replace_text = make_import_path(relative_after, import_separator),
    is_close = false, -- close an existing instance of spectre and open new
  })
end

return M
