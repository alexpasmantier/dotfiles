return {
  {
    dir = "~/code/lua/krust.nvim/",
    ft = "rust",
    opts = {
      keymap = "<leader>k", -- Set a keymap for Rust buffers (default: false)
      float_win = {
        border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
        auto_focus = false, -- Auto-focus float (default: false)
      },
    },
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup({
        lsp = {
          enabled = true,
          on_attach = function(client, bufnr)
            -- the same on_attach function as for your other language servers
            -- can be ommited if you're using the `LspAttach` autocmd
          end,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },
}
