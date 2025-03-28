vim.cmd.packadd 'packer.nvim'
require("packer").startup(function()
  -- color
  use({
    'EdenEast/nightfox.nvim',
    config = function() require('nightfox').setup({
      -- highlightはターミナル背景透過設定有効時のため
      vim.cmd([[
        colorscheme nordfox
      ]])
    })
    end,
  })

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
      highlight = { enable = true },
      indent = { enable = true },
    })
    end,
  }

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    config = function() require('lualine').setup({
      options = {
        globalstatus = true,
      }
    })
    end,
  }

  -- LSP(及びautocomplete)
  use { 'neoclide/coc.nvim', branch='release' }

  -- linter
  use {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_fixers = {
        javascript = { 'eslint', 'biome' },
        typesciprt = { 'eslint', 'biome' },
        ruby = 'rubocop'
      }
      vim.g.ale_linter_aliases = {
        vue = { 'javascript', 'html' }
      }
      vim.g.ale_ruby_rubocop_executable = 'bundle'
    end,
  }

  -- finder
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    module = { "telescope" },
    requires = { {'nvim-lua/plenary.nvim'} },
    setup = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
    end,
  }

  -- text_object
  use {
    'David-Kunz/treesitter-unit',
    config = function()
      vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
      vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', {noremap=true})
      vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})
      vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})
    end,
  }
  use 'machakann/vim-sandwich'

  -- quickfix
  -- quickfixを普通に編集出来る。todoの消し込みとかで便利
  use 'itchyny/vim-qfedit'

  -- ファイル内のoutlineを表示
  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end
  }

  -- coffee-script排除できたら不要
  use 'kchmck/vim-coffee-script'
  -- rails support
  use 'tpope/vim-rails'
  -- 一括コメントアウト
  use 'sakuraiyuta/commentout.vim'
  -- 一括置換
  use 'thinca/vim-qfreplace'
  -- Git( Git blameのみたまに使う)
  use 'tpope/vim-fugitive'
end)
