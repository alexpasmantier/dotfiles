local M = {}

-- to be formatted using the full import path to the renamed file/dir
local IMPORT_PATH_REGEX = [[%s(?:\.[a-zA-Z0-9_]+)*]]
local IMPORT_MODULE_REGEX = [[import\s+]] .. IMPORT_PATH_REGEX
local FROM_MODULE_IMPORT_X_REGEX = [[from\s+]] .. IMPORT_PATH_REGEX .. [[\s+import\s+]]

-- to be formatted using the base path and the module name (e.g. `path.to` and `module`)
local FROM_PACKAGE_IMPORT_MODULE_REGEX = [[from\s+%s\s+import\s+\(?\n[\sa-zA-Z0-9_,\n]+\)]]
local MULTILINE_FROM_PACKAGE_IMPORT_MODULE_REGEX = [[from\s+%s\s+import\s+(?:\(\n)(?:\s+[a-zA-Z0-9_]+,?\n)+\)]]

local SPLIT_IMPORT_REGEX = [[from\s+%s\s+import\s+\(?\n?[\sa-zA-Z0-9_,\n]+\)?\s*$]]

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
    import_module = string.format([[import\s+%s()]], escaped_module_import_path),
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

local Job = require("plenary.job")

local function global_sed(rg_job_results, sed_args)
  local file_paths = {}
  for _, line in ipairs(rg_job_results) do
    local t = vim.json.decode(line)
    if t.type == "match" then
      table.insert(file_paths, t.data.path.text)
    end
  end
  if #file_paths == 0 then
    return
  end
  Job:new({
    command = "zsh",
    args = {
      "-c",
      "sed -i '' " .. table.concat(sed_args, " ") .. " " .. table.concat(file_paths, " "),
    },
  }):start()
end

local function log_to_file(text)
  local file = io.open("/tmp/imports.log", "a")
  file:write("\n")
  file:write(text)
  file:close()
end

local MATCH = "match"

local function ranged_sed(rg_job_results, sed_args)
  local matches = {}
  for _, line in ipairs(rg_job_results) do
    local t = vim.json.decode(line)
    if t.type == MATCH then
      local additional_line_count = select(2, t.data.lines.text:gsub("\n", "")) - 1
      table.insert(
        matches,
        { path = t.data.path.text, lines = { t.data.line_number, t.data.line_number + additional_line_count } }
      )
    end
  end
  if #matches == 0 then
    return
  end
  for _, match in ipairs(matches) do
    Job
      :new({
        command = "zsh",
        args = {
          "-c",
          "sed -i '' "
            .. string.format(table.concat(sed_args, " "), match.lines[1], match.lines[2])
            .. " "
            .. match.path,
        },
      })
      :start()
  end
end

-- @param rg_args table: The arguments to pass to rg
-- @param sed_args table: The arguments to pass to sed
-- @param range bool: Whether or not to call sed with a range specifier
local function rg_into_sed(rg_args, sed_args, range)
  Job:new({
    command = "zsh",
    args = { "-c", "rg " .. table.concat(rg_args, " ") },
    on_exit = function(job, _)
      if range then
        ranged_sed(job:result(), sed_args)
      else
        global_sed(job:result(), sed_args)
      end
    end,
  }):start()
end

local filetype = require("plenary.filetype")
local Path = require("plenary.path")

local function is_python_file(path)
  return filetype.detect(path, {}) == "python"
end

local function recursive_dir_contains_python_files(path)
  local files = vim.fn.readdir(path)
  for _, file in ipairs(files) do
    local full_path = path .. "/" .. file
    if vim.fn.isdirectory(full_path) == 1 then
      if recursive_dir_contains_python_files(full_path) then
        return true
      end
    elseif is_python_file(full_path) then
      return true
    end
  end
  return false
end

function M.update_imports(source, destination)
  if not is_python_file(source) then
    if not recursive_dir_contains_python_files(source) then
      return
    end
  end

  local cwd = vim.fn.getcwd()

  local source_relative = Path:new(source):make_relative(cwd)
  local destination_relative = Path:new(destination):make_relative(cwd)

  -- path.to.file/dir
  local source_import_path = get_import_path(source_relative)
  local destination_import_path = get_import_path(destination_relative)

  -- path.to and file/dir
  local source_base_path, source_module_name = split_import_path(source_import_path)
  local destination_base_path, destination_module_name = split_import_path(destination_import_path)

  -- easy case: `import path.to.file/dir[...]`
  local rg_args =
    { "--json", "-t", "py", "-t", "md", string.format("'%s'", escape_import_path(source_import_path)), "." }
  log_to_file("rg " .. table.concat(rg_args, " "))
  local sed_args = {
    "'s/" .. escape_import_path(source_import_path) .. "/" .. escape_import_path(destination_import_path) .. "/'",
  }
  rg_into_sed(rg_args, sed_args)

  -- harder case: `from path.to.dir import file` (potentially multiline)
  local rg_args_split = {
    "--json",
    "-U",
    "-t",
    "py",
    "-t",
    "md",
    string.format("'%s'", SPLIT_IMPORT_REGEX:format(escape_import_path(source_base_path))),
    ".",
  }
  log_to_file("rg " .. table.concat(rg_args_split, " "))
  local sed_args_base = {
    "'%s,%ss/" .. escape_import_path(source_base_path) .. "/" .. escape_import_path(destination_base_path) .. "/'",
  }
  local sed_args_module = {
    "'%s,%ss/" .. escape_import_path(source_module_name) .. "/" .. escape_import_path(destination_module_name) .. "/'",
  }
  rg_into_sed(rg_args_split, sed_args_base, true)
  rg_into_sed(rg_args_split, sed_args_module, true)

  -- this needs to happen once the jobs are done -> investigate
  vim.api.nvim_command("checktime")
end

return M
