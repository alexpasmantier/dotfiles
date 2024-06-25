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

-- local IMPORT_SEPARATORS = {
--   python = ".",
--   rust = "::",
--   lua = ".",
--   typescript = "/",
--   javascript = "/",
--   typescriptreact = "/",
--   javascriptreact = "/",
-- }
-- local DEFAULT_IMPORT_SEPARATOR = "."
--
-- local function get_import_separator(ft)
--   if ft == nil then
--     return DEFAULT_IMPORT_SEPARATOR
--   else
--     return IMPORT_SEPARATORS[ft] or DEFAULT_IMPORT_SEPARATOR
--   end
-- end
--
-- local function truncate_str_at_last_occurence_of_char(str, char)
--   local parts = string.gmatch(str, "[^" .. char .. "]+")
--   local final_parts = {}
--   for part in parts do
--     table.insert(final_parts, part)
--   end
--   local final_str = table.concat(final_parts, char, 1, #final_parts - 1)
--   return final_str
-- end
--
-- local function make_import_path(relative_file_path, import_separator)
--   local path_without_suffix = truncate_str_at_last_occurence_of_char(relative_file_path, ".")
--   local import_path = string.gsub(path_without_suffix, "/", import_separator)
--   return import_path
-- end
-- --[[
-- scripts[./]load[./]international_tax_agreement[./]transform[./]const(.py)?
--
-- scripts/load/international_tax_agreement/transform/toot.py
-- --]]
-- function M.open_spectre_with_renaming(before, after)
--   local Path = require("plenary.path")
--   local filetype = require("plenary.filetype")
--   local cwd = vim.fn.getcwd()
--   local import_separator = get_import_separator(filetype.detect(before, {}))
--   local relative_before = Path:new(before):make_relative(cwd)
--   local relative_after = Path:new(after):make_relative(cwd)
--
--   require("spectre").open({
--     is_insert_mode = false,
--     search_text = make_import_path(relative_before, import_separator),
--     replace_text = make_import_path(relative_after, import_separator),
--     is_close = false, -- close an existing instance of spectre and open new
--   })
-- end

-- @param module_path string: The path to a python module
-- @return string: The import path for the module
local function get_import_path(module_path)
  return module_path:gsub("/", "."):gsub("%.py$", "")
end

-- @param import_path string: The import path to be split
-- @return string, string: The base path and the last part of the import path
local function split_import_path(import_path)
  local base_path, module_name = import_path:match("(.-)%.?([^%.]+)$")
  return base_path, module_name
end

-- @param import_path string: The import path to be escaped
local function escape_import_path(import_path)
  return import_path:gsub("%.", [[\.]])
end

-- @param module_import_path string: The import path to the module to be renamed
-- @return table: A table containing regex patterns for different import statements
local function generate_python_import_regex_variants(module_import_path)
  -- Split the module_import_path to get the base and the last part
  local base_path, module_name = split_import_path(module_import_path)

  -- Escape dots in the module import path for regex
  local escaped_module_import_path = escape_import_path(module_import_path)
  local escaped_base_path = escape_import_path(base_path)
  local escaped_module_name = escape_import_path(module_name)

  -- Create the regex patterns
  local regex_variants = {
    -- import path.to.module
    direct_import = string.format([[\s*import\s+%s\s*]], escaped_module_import_path),
    -- from path.to.module import X, Y, Z
    from_full_import_x = string.format(
      [[\s*from\s+%s\s+import\s+[a-zA-Z_*][a-zA-Z0-9_]*(?:\s*,\s*[a-zA-Z_*][a-zA-Z0-9_]*)*\s*]],
      escaped_module_import_path
    ),
    -- from path.to import module
    from_sub_import_last = string.format([[\s*from\s+%s\s+import\s+%s\s*]], escaped_base_path, escaped_module_name),
  }

  return regex_variants
end

-- @param source string: The path to the source file
-- @param destination string: The path to the destination file
function M.update_python_imports_after_renaming(source, destination)
  local Job = require("plenary.job")
  local Path = require("plenary.path")
  local cwd = vim.fn.getcwd()

  local source_relative = Path:new(source):make_relative(cwd)
  local destination_relative = Path:new(destination):make_relative(cwd)

  local source_import_path = get_import_path(source_relative)
  local destination_import_path = get_import_path(destination_relative)

  local destination_base_path, destination_module_name = split_import_path(destination_import_path)

  local source_import_regex_variants = generate_python_import_regex_variants(source_import_path)

  -- `import path.to.module`
  local rg_args = { "-l", "'" .. source_import_regex_variants.direct_import .. "'", "." }
  local sed_args = {
    "-i",
    "'s/" .. escape_import_path(source_import_path) .. "/" .. escape_import_path(destination_import_path) .. "/g'",
  }

  local on_exit = function(obj)
    -- vim.print(obj.code)
    -- vim.print(obj.signal)
    -- vim.print(obj.stdout)
    -- vim.print(obj.stderr)
  end
  table.insert(rg_args, 1, "rg")
  local obj = vim.system(rg_args, { text = true }, on_exit):wait()
  -- Job:new({
  --   command = "rg",
  --   args = rg_args,
  --   cwd = cwd,
  --   skip_validation = true,
  --   enabled_recording = true,
  --   on_stderr = function(error, data)
  --     vim.print("Error:", error)
  --     vim.print("Data:", data)
  --   end,
  --   on_exit = function(job)
  --     vim.print("Job exit code:", job.code)
  --     -- vim.print("Job stderr:", job:stderr_result())
  --     -- vim.print(vim.inspect(job:stderr_result()))
  --   end,
  --   -- on_stdout = function(error, data)
  --   --   local buf = vim.api.nvim_create_buf(false, true)
  --   --   vim.api.nvim_buf_set_lines(buf, 0, -1, true, { "Data:", data })
  --   --   local opts = {
  --   --     relative = "cursor",
  --   --     width = 10,
  --   --     height = 2,
  --   --     col = 0,
  --   --     row = 1,
  --   --     anchor = "NW",
  --   --     style = "minimal",
  --   --   }
  --   --   local win = vim.api.nvim_open_win(buf, 0, opts)
  --   --   -- optional: change highlight, otherwise Pmenu is used
  --   --   vim.api.nvim_win_set_option(win, "winhl", "Normal:MyHighlight")
  --   -- end,
  -- }):sync() -- or start()

  -- `from path.to.module import X, Y, Z`
  local command2 = (
    'rg -l --python "'
    .. source_import_regex_variants.from_full_import_x
    .. '"'
    .. " "
    .. cwd
    .. " | xargs sed -i '' 's/"
    .. source_import_regex_variants.from_full_import_x
    .. "/"
    .. "from "
    .. destination_import_path
    .. " import "
    .. destination_module_name
    .. "/g'"
  )

  -- `from path.to import module`
end

return M
