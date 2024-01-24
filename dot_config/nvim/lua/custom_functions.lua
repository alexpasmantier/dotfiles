M = {}

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

return M
