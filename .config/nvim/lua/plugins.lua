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

  -- autocomplete
  -- cod

  -- ale

  -- 何かfizzy finder系を試す。従来はfzf使ってた

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
