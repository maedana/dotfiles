--------------------------------------------------------------------------------
-- plugins
--------------------------------------------------------------------------------
require "plugins"

--------------------------------------------------------------------------------
-- etc
--------------------------------------------------------------------------------
vim.o.compatible = false
vim.o.number = true
vim.o.backup = false
vim.o.swapfile = false
-- vim開始時の挨拶を表示しない
vim.opt.shortmess:append({ I = true })
-- メッセージ表示に使う行数
vim.o.cmdheight = 1
-- バッファ放棄時にhidden状態になる
vim.o.hidden = true
-- コマンド保存数
vim.o.history = 1000
-- backspaceキーを使えるようにする
vim.opt.backspace = "indent,eol,start"
-- 行をまたいで移動出来るようにする
vim.o.whichwrap = 'b,s,h,l,<,>,[,]'
--全角記号対策
vim.o.ambiwidth = 'double'
-- ヤンクでクリップボードにコピー。外部ツールのインストールが必要。詳しくはdocument参照
vim.opt.clipboard:append({ 'unnamedplus' })
-- Tabの可視化
vim.o.list = true
vim.o.listchars = 'tab:»-'
-- <Leader>をSpaceに
vim.g.mapleader = ' '

-- grep設定
-- rgがあれば使う
if vim.fn.executable('rg') then
  vim.o.grepprg = 'rg --vimgrep'
  vim.o.grepformat = '%f:%l:%c:%m'
end

--------------------------------------------------------------------------------
-- tabkey
--------------------------------------------------------------------------------
vim.o.cindent = true
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.tabstop = 2

--------------------------------------------------------------------------------
-- search
--------------------------------------------------------------------------------
-- .が何か一文字という意味になる
vim.o.magic = true
-- 大文字が含まれている時のみ、大文字と小文字が区別される
vim.o.ignorecase = true
vim.o.smartcase = true
-- 検索結果の強調表示する
-- https://github.com/neovim/neovim/issues/23590 の現象で遅くなるので検索ハイライト無効化。なくてもそんなに困らないし
vim.o.hlsearch = false
-- インクリメンタルサーチする
vim.o.incsearch = true

--------------------------------------------------------------------------------
-- status line
--------------------------------------------------------------------------------
-- ステータスライン常に表示。画面分割してもステータスラインは1つ
vim.o.laststatus = 3
-- コマンドライン補完を拡張モードにする
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest,full'
-- 現在のカーソル位置(行、桁)を右下に常に表示
vim.o.ruler = true
-- 入力途中のコマンドを表示
vim.o.showcmd = true

--------------------------------------------------------------------------------
-- encode
--------------------------------------------------------------------------------
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

--------------------------------------------------------------------------------
-- folding
--------------------------------------------------------------------------------
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 20
vim.o.foldlevel = 20
-- 行頭で h を押すと折畳を閉じる。
vim.api.nvim_set_keymap('n', 'h', "col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'", { expr = true, noremap = true, silent = true })
-- 折畳上で l を押すと折畳を開く。
vim.api.nvim_set_keymap('n', 'l', "foldclosed(line('.')) != -1 ? 'zo0' : 'l'", { expr = true, noremap = true, silent = true })
-- 行頭で h を押すと選択範囲に含まれる折畳を閉じる。
vim.api.nvim_set_keymap('v', 'h', "col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'", { expr = true, noremap = true, silent = true })
-- 折畳上で l を押すと選択範囲に含まれる折畳を開く。
vim.api.nvim_set_keymap('v', 'l', "foldclosed(line('.')) != -1 ? 'zogv0' : 'l'", { expr = true, noremap = true, silent = true })

--------------------------------------------------------------------------------
-- autocomplete
--------------------------------------------------------------------------------
vim.o.completeopt = 'menuone,noinsert'

--------------------------------------------------------------------------------
-- buffer
--------------------------------------------------------------------------------
vim.api.nvim_set_keymap('', '<LEFT>', ':bp!<CR>', {})
vim.api.nvim_set_keymap('', '<RIGHT>', ':bn!<CR>', {})

--------------------------------------------------------------------------------
-- move
--------------------------------------------------------------------------------
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

--------------------------------------------------------------------------------
-- pair
--------------------------------------------------------------------------------
vim.o.showmatch = true
