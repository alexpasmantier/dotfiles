return {

  {
    "folke/flash.nvim",
    config = function()
      require("flash").setup({
        mode = function(str)
          return "\\<" .. str
        end,
      })
      -- additional highlight settings
      vim.api.nvim_set_hl(0, "FlashCurrent", { bg = "#f2c168", bold = true, underline = true })
      vim.api.nvim_set_hl(0, "FlashMatch", { underline = true, bold = true })
      vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#f2c168", bold = true })
    end,
  },
  "mg979/vim-visual-multi",
}
