vim.cmd.packadd 'packer.nvim'
require("packer").startup(function()
  -- color
  use 'rebelot/kanagawa.nvim'

  -- syntax
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function() require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      ignore_install = { 'phpdoc' },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
    end,
  }

  -- statusline系
  -- nvim-lualine/lualine.nvim を試したい

  -- LSP(及びautocomplete)
  use { 'neoclide/coc.nvim', branch='release' }

  -- ale
  use 'dense-analysis/ale'

  -- 何かfizzy finder系を試す。従来はfzf使ってた
  -- https://github.com/nvim-telescope/telescope-file-browser.nvim を試したい

  -- coffee-script排除できたら不要
  use 'kchmck/vim-coffee-script'
  -- rails support
  use 'tpope/vim-rails'
  -- 一括コメントアウト
  use 'sakuraiyuta/commentout.vim'
  -- 一括置換
  use 'thinca/vim-qfreplace'
  -- Git
  use 'tpope/vim-fugitive'
end)
