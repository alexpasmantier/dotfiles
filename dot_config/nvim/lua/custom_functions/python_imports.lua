local M = {}

-- to be formatted using the full import path to the renamed file/dir
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

-- @param hang_time number: The time to wait before refreshing the buffers
local function async_refresh_buffers(hang_time)
  vim.defer_fn(function()
    vim.api.nvim_command("checktime")
  end, hang_time or 1000)
end

--[[
from path.to.dir import file
from path.to.dir import (
    file1,
    file2,
)
from path.to.file import Something
--]]
-- @param source string: The path to the source file/dir
-- @param destination string: The path to the destination file/dir
local function update_imports_split(source, destination)
  local cwd = vim.fn.getcwd()

  local source_relative = Path:new(source):make_relative(cwd)
  local destination_relative = Path:new(destination):make_relative(cwd)

  -- path.to.file/dir
  local source_import_path = get_import_path(source_relative)
  local destination_import_path = get_import_path(destination_relative)

  -- path.to and file/dir
  local source_base_path, source_module_name = split_import_path(source_import_path)
  local destination_base_path, destination_module_name = split_import_path(destination_import_path)

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
  local sed_args_base = {
    "'%s,%ss/" .. escape_import_path(source_base_path) .. "/" .. escape_import_path(destination_base_path) .. "/'",
  }
  local sed_args_module = {
    "'%s,%ss/" .. escape_import_path(source_module_name) .. "/" .. escape_import_path(destination_module_name) .. "/'",
  }
  rg_into_sed(rg_args_split, sed_args_base, true)
  rg_into_sed(rg_args_split, sed_args_module, true)
end

--[[
from path.to.dir import file
from path.to.dir import (
   file1,
   file2,
)
]]
-- @param source string: The path to the source file/dir
-- @param destination string: The path to the destination file/dir
local function update_imports_monolithic(source, destination)
  local cwd = vim.fn.getcwd()

  -- path/to/here
  local source_relative = Path:new(source):make_relative(cwd)
  local destination_relative = Path:new(destination):make_relative(cwd)

  -- path.to.here
  local source_import_path = get_import_path(source_relative)
  local destination_import_path = get_import_path(destination_relative)

  local rg_args =
    { "--json", "-t", "py", "-t", "md", string.format("'%s'", escape_import_path(source_import_path)), "." }
  local sed_args = {
    "'s/" .. escape_import_path(source_import_path) .. "/" .. escape_import_path(destination_import_path) .. "/'",
  }
  rg_into_sed(rg_args, sed_args)
end

-- @param source string: The path to the source file/dir
-- @param destination string: The path to the destination file/dir
function M.update_imports(source, destination)
  if is_python_file(source) and is_python_file(destination) then
    update_imports_split(source, destination)
  elseif recursive_dir_contains_python_files(source) then
    update_imports_monolithic(source, destination)
  end
  async_refresh_buffers()
end

return M
