vim.cmd.packadd 'packer.nvim'
require("packer").startup(function()
  -- color
  use {
    'EdenEast/nightfox.nvim',
    config = function() require('nightfox').setup({
      vim.cmd([[
        colorscheme nordfox
        highlight Normal ctermbg=NONE guibg=NONE
        highlight NonText ctermbg=NONE guibg=NONE
        highlight LineNr ctermbg=NONE guibg=NONE
        highlight Folded ctermbg=NONE guibg=NONE
        highlight EndOfBuffer ctermbg=NONE guibg=NONE
      ]])
    })
    end,
  }

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
        javascript = 'eslint',
        typesciprt = 'eslint'
      }
      vim.g.ale_linter_aliases = {
        vue = { 'javascript', 'html' }
      }
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
      vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fg', builtin.grep_string, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
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

  -- ファイル内のoutlineを表示
  use 'stevearc/aerial.nvim'

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
