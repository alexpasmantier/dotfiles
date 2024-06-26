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
  -- FIXME: these do not cover all cases:
  -- imports that are split across multiple lines
  -- renaming of packages (directories)
  -- others?
  local regex_variants = {
    -- import path.to.module
    import_module = string.format([[\s*import\s+%s\s*]], escaped_module_import_path),
    -- from path.to.module import X, Y, Z
    from_module_import_x = string.format(
      [[\s*from\s+%s\s+import\s+(?:[a-zA-Z_*][a-zA-Z0-9_]*(?:\s*,\s*[a-zA-Z_*][a-zA-Z0-9_]*)*|\()\s*]],
      escaped_module_import_path
    ),
    -- from path.to import module
    from_package_import_module = string.format(
      [[\s*from\s+%s\s+import\s+%s\s*]],
      escaped_base_path,
      escaped_module_name
    ),
  }

  return regex_variants
end

local function rg_into_sed(rg_args, sed_args)
  local Job = require("plenary.job")
  Job:new({
    command = "zsh",
    args = { "-c", "rg " .. table.concat(rg_args, " ") },
    on_exit = function(job, _)
      local files = {}
      for _, line in ipairs(job:result()) do
        local t = vim.json.decode(line)
        if t.type == "match" then
          table.insert(files, t.data.path.text)
        end
      end
      Job:new({
        command = "zsh",
        args = {
          "-c",
          "sed -i '' " .. string.format(table.concat(sed_args, " "), "") .. " " .. table.concat(files, " "),
        },
      }):start()
      -- NOTE: the following was nice because it only tried to modify the lines that matched
      -- but spawned a new asynchronous job for each file which ended up opening too many file descriptors
      -- resulting in `EMFILE: too many open files`
      -- for _, line in ipairs(job:result()) do
      --   local t = vim.json.decode(line)
      --   -- we're only interested in matches
      --   if t.type ~= "match" then
      --     goto continue
      --   end
      --   local file = t.data.path.text
      --   local line_number = t.data.line_number
      --   local sed_command = "sed -i '' " .. string.format(table.concat(sed_args, " "), line_number) .. " " .. file
      --   Job:new({
      --     command = "zsh",
      --     args = { "-c", sed_command },
      --     on_exit = function(job, _) end,
      --   }):start()
      --   ::continue::
      -- end
    end,
  }):start()
end

-- @param source string: The path to the source file
-- @param destination string: The path to the destination file
function M.update_python_imports_after_renaming(source, destination)
  local filetype = require("plenary.filetype")
  if filetype.detect(source, {}) ~= "python" or filetype.detect(destination, {}) ~= "python" then
    return
  end

  local Path = require("plenary.path")
  local cwd = vim.fn.getcwd()

  local source_relative = Path:new(source):make_relative(cwd)
  local destination_relative = Path:new(destination):make_relative(cwd)

  local source_import_path = get_import_path(source_relative)
  local destination_import_path = get_import_path(destination_relative)

  local source_base_path, source_module_name = split_import_path(source_import_path)
  local destination_base_path, destination_module_name = split_import_path(destination_import_path)

  local source_import_regex_variants = generate_python_import_regex_variants(source_import_path)

  -- `import path.to.module`
  local rg_args = { "--json", string.format("'%s'", source_import_regex_variants.import_module), "." }
  local sed_args = {
    "'%ss/" .. escape_import_path(source_import_path) .. "/" .. escape_import_path(destination_import_path) .. "/'",
  }
  rg_into_sed(rg_args, sed_args)

  -- `from path.to.module import X, Y, Z`
  local rg_args_1 = { "--json", string.format("'%s'", source_import_regex_variants.from_module_import_x), "." }
  local sed_args_1 = {
    "'%ss/" .. escape_import_path(source_import_path) .. "/" .. escape_import_path(destination_import_path) .. "/'",
  }
  rg_into_sed(rg_args_1, sed_args_1)

  -- `from path.to import module`
  local rg_args_2 = { "--json", string.format("'%s'", source_import_regex_variants.from_package_import_module), "." }
  local sed_args_base = {
    "'%ss/" .. escape_import_path(source_base_path) .. "/" .. escape_import_path(destination_base_path) .. "/'",
  }
  local sed_args_module = {
    "'%ss/" .. escape_import_path(source_module_name) .. "/" .. escape_import_path(destination_module_name) .. "/'",
  }
  -- NOTE: this is fine, rg being so fast
  rg_into_sed(rg_args_2, sed_args_base)
  rg_into_sed(rg_args_2, sed_args_module)
end

return M
