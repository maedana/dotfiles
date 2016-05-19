"==<etc>======================================================================
" vi互換機能オフ
set nocompatible
" バックアップを作らない
set nobackup
" swpファイルを作らない
set noswapfile
" vim開始時の挨拶を表示しない
set shortmess+=I
" 行番号表示
set number
" メッセージ表示に使う行数
set cmdheight=1
" バッファ放棄時にhidden状態になる
set hidden
" コマンド保存数
set history=1000
" backspaceキーを使えるようにする
set backspace=indent,eol,start
" mouse mode
set mouse=a
" 行をまたいで移動出来るようにする
set whichwrap=b,s,h,l,<,>,[,]
" 全角記号対策
set ambiwidth=double
"ヤンクでクリップボードにコピー。外部ツールのインストールが必要。詳しくはdocument参照
set clipboard+=unnamedplus

" grep設定
" agがあれば使う
if executable('ag')
  set grepprg=ag\ --nogroup
  set grepformat=%f:%l:%m
endif

" <Leader>及び<LocalLeader>をデフォルトの\からspaceにする
let mapleader = ' '
let maplocalleader = ' '

"==<tabkey>===================================================================
set cindent
set expandtab
set softtabstop=2
set shiftwidth=2
set tabstop=2

autocmd BufEnter * call SetTab()
function! SetTab()
  execute 'set softtabstop=2 | set shiftwidth=2 | set tabstop=2'
endfunction

"==<search>===================================================================
" .が何か一文字という意味になる
set magic
" 大文字が含まれている時のみ、大文字と小文字が区別される
set ignorecase smartcase
" 検索結果の強調表示する
set hlsearch
" インクリメンタルサーチする
set incsearch

"==<status line>==============================================================
" ステータスラインを常に表示
set laststatus=2
" ステータスラインに文字コードと改行コードを表示させる
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" コマンドライン補完を拡張モードにする
set wildmenu
set wildmode=list:longest,full
" 現在のカーソル位置(行、桁)を右下に常に表示
set ruler
" 入力途中のコマンドを表示
set showcmd

"==<encode>===================================================================
set encoding=utf-8
set fileencoding=utf-8

"==<folding>==================================================================
set foldmethod=indent
set foldlevelstart=20
set foldlevel=20
" via http://d.hatena.ne.jp/ns9tks/20080318/1205851539
" 行頭で h を押すと折畳を閉じる。
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" 折畳上で l を押すと折畳を開く。
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" 行頭で h を押すと選択範囲に含まれる折畳を閉じる。
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" 折畳上で l を押すと選択範囲に含まれる折畳を開く。
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

"==omunicomplete==============================================================
" omunicompleteでpreviewが出ないようにする
set completeopt=menuone

"==<buffer>===================================================================
map <LEFT> :bp!<CR>
map <RIGHT> :bn!<CR>
map <UP> :ls<CR>
map <DOWN> :b!<SPACE>

"==<move>=====================================================================
nnoremap j gj
nnoremap k gk

"==<pair>=====================================================================
set showmatch

syntax on

"==<NeoBundle>================================================================
filetype off

if has('vim_starting')
  set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.config/nvim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neobundle.vim'
" ==language-support
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-rails'
NeoBundle 'fatih/vim-go'
" ==develop-support
NeoBundle 'sakuraiyuta/commentout.vim'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'cohama/lexima.vim'
" ==snippets
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
" ==autocomplete
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'zchee/deoplete-go', {'build': {'unix': 'make'}}
" ==misc
NeoBundle 'vim-scripts/xoria256.vim'
NeoBundle 'wakatime/vim-wakatime'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'yanktmp.vim'
call neobundle#end()

filetype plugin on
filetype indent on
NeoBundleCheck

"==<plugin>===================================================================
"yanktmp.vim(via id:secondlife
if v:version >= 700
  let g:yanktmp_file = $HOME . '/.vimyanktmp'
  map <silent> sy :call YanktmpYank()<CR>
  map <silent> sp :call YanktmpPaste_p()<CR>
  map <silent> sP :call YanktmpPaste_P()<CR>
endif

"deoplete
":DeopleteEnable実行でもよい
let g:deoplete#enable_at_startup = 1
"Tabで補完を選択
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

"deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#align_class = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#package_dot = 1

"syntastic
"Ruby ファイルに対し RuboCop を実行する
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_go_checkers = ['golint', 'gotype', 'govet', 'go']

"ultisnips
"snippetの展開(tabだと補完候補の選択とぶつかるので<c-k>にした)
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

"==<color>===================================================================
"xoria256
colorscheme xoria256
highlight Pmenu      ctermbg=8  guibg=#808080
highlight PmenuSel   ctermbg=12 guibg=#8080ff
highlight PmenuSbar  ctermbg=0  guibg=#000000
"背景透過のため
highlight Normal ctermbg=none
highlight NonText ctermbg=none
"スペースの可視化
highlight ZenkakuSpace ctermbg=6
match ZenkakuSpace /\s\+$\|　/
"Tabの可視化
set list
set listchars=tab:»-
