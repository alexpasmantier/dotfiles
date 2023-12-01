local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- colorschemes
  use 'folke/tokyonight.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'wadackel/vim-dogrun'
  use 'catppuccin/nvim'
  use 'rebelot/kanagawa.nvim'
  use 'shaunsingh/nord.nvim'
  -- use 'norcalli/nvim-colorizer.lua'
  -- require 'colorizer'.setup()

  -- autopairs
  use 'windwp/nvim-autopairs'

  -- comments
  use 'numToStr/Comment.nvim'

  -- git
  use { 'tpope/vim-fugitive' }
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  }

  -- status line
  use 'nvim-lualine/lualine.nvim'
  -- use 'itchyny/lightline.vim'

  -- org mode
  use {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers", -- This is the important bit!
  }
  -- file explorer
  use {
    'nvim-neo-tree/neo-tree.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      's1n7ax/nvim-window-picker',
    },
  }

  -- autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'saadparwaiz1/cmp_luasnip',
    }
  }

  -- indentation
  use 'tpope/vim-sleuth'
  use "lukas-reineke/indent-blankline.nvim"

  -- snippets
  use {
    'L3MON4D3/LuaSnip',
    requires = { 'rafamadriz/friendly-snippets' },
    run = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil
  }

  -- search and replace
  use 'nvim-pack/nvim-spectre'

  -- multiline editing
  use 'mg979/vim-visual-multi'

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'nvim-telescope/telescope-fzf-native.nvim'
  use 'nvim-telescope/telescope-project.nvim'

  -- todo comments
  use 'folke/todo-comments.nvim'

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'

  -- whichkey
  use { 'folke/which-key.nvim' }

  -- markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })

  -- LSP
  use 'folke/neodev.nvim'
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  }


  -- Linting
  use 'mfussenegger/nvim-lint'

  -- Formatting
  use 'stevearc/conform.nvim'

  -- Goto definition preview
  use 'rmagatti/goto-preview'

  -- LSP outline
  use "stevearc/aerial.nvim"

  -- signature help
  -- use "ray-x/lsp_signature.nvim"

  -- session
  use 'folke/persistence.nvim'

  -- movement
  -- use 'ggandor/leap.nvim'
  use 'folke/flash.nvim'

  -- zen mode
  use { 'folke/zen-mode.nvim', requires = { 'folke/twilight.nvim' } }

  -- toggleterm (terminal)
  use { "akinsho/toggleterm.nvim", tag = '*' }

  -- firenvim
  -- use {
  --   'glacambre/firenvim',
  --   run = function() vim.fn['firenvim#install'](0) end
  -- }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
