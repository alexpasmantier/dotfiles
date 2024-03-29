return {
  {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers", -- This is the important bit!
    enabled = not vim.g.started_by_firenvim,
    opts = {
      load = {
        ["core.defaults"] = {},  -- default behaviour
        ["core.concealer"] = {}, -- pretty icons while typing
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.export"] = {},
        ["core.summary"] = {},
        ["core.presenter"] = {
          config = { zen_mode = "zen-mode" },
        },
      },
    },
  },
}
