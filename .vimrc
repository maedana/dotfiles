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
set ttymouse=xterm2
" folding
set foldmethod=indent
set foldlevel=1
set ambiwidth=double
" via http://d.hatena.ne.jp/ns9tks/20080318/1205851539
" 行頭で h を押すと折畳を閉じる。
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" 折畳上で l を押すと折畳を開く。
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" 行頭で h を押すと選択範囲に含まれる折畳を閉じる。
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" 折畳上で l を押すと選択範囲に含まれる折畳を開く。
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

" <Leader>及び<LocalLeader>をデフォルトの\からspaceにする
let mapleader = ' '
let maplocalleader = ' '

syntax on

"==<NeoBundle>================================================================
"see http://vim-users.jp/2011/10/hack238/
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" vim-scripts repos
NeoBundle 'yanktmp.vim'

" original repos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimproc'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'sakuraiyuta/commentout.vim'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'kchmck/vim-coffee-script'

filetype plugin on
filetype indent on

"==<plugin>===================================================================
"yanktmp.vim(via id:secondlife
if v:version >= 700
  let g:yanktmp_file = $HOME . '/.vimyanktmp'
  map <silent> sy :call YanktmpYank()<CR>
  map <silent> sp :call YanktmpPaste_p()<CR>
  map <silent> sP :call YanktmpPaste_P()<CR>
endif

"neocomplecache.vim
let g:neocomplcache_enable_at_startup = 1

"==<tabkey>===================================================================
set cindent
set expandtab
set softtabstop=2
set shiftwidth=2
set tabstop=2

autocmd BufEnter * call SetTab()

function! SetTab()
  if &syntax == 'ruby' || &syntax == 'python' || &syntax == 'html' || &syntax == 'xhtml' || &syntax == 'css' || &syntax == 'eruby' || &syntax == 'yaml' || &syntax == 'vim' || &syntax == 'haml' || &syntax == 'sass' || &syntax == 'xml' || &syntax == 'javascript.jquery' || &syntax == 'coffee'
    execute 'set softtabstop=2 | set shiftwidth=2 | set tabstop=2'
  else
    execute 'set softtabstop=4 | set shiftwidth=4 | set tabstop=4'
  endif
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

"==<color>====================================================================
colorscheme xoria256
"autocmd VimEnter * :GuiColorScheme xoria256

set listchars=tab:>_
set list
"highlight SpecialKey guifg=#555555
"
highlight Pmenu      ctermbg=8  guibg=#808080
highlight PmenuSel   ctermbg=12 guibg=#8080ff
highlight PmenuSbar  ctermbg=0  guibg=#000000

"==<encode>===================================================================
set encoding=utf-8
set fileencoding=utf-8

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  let &fileencodings = &fileencodings .','. s:enc_jis
  set fileencodings+=utf-8,ucs-2le,ucs-2
  if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    set fileencodings+=cp932
    set fileencodings-=euc-jp
    set fileencodings-=euc-jisx0213
    let &encoding = s:enc_euc
  else
    let &fileencodings = &fileencodings .','. s:enc_euc
  endif

  unlet s:enc_euc
  unlet s:enc_jis
endif

" 補完をTabキーで出来るようにする
function! InsertTabWrapper()
  if pumvisible()
    return "\<C-N>"
  endif

  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k\|<\|/'
    return "\<TAB>"
  elseif &omnifunc == ''
    return "\<C-P>"
  else
    return "\<C-X>\<C-O>"
  endif
endfunction
inoremap <TAB> <C-R>=InsertTabWrapper()<CR>

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

"==<vim-reading#04より>=======================================================
highlight ZenkakuSpace ctermbg=6
match ZenkakuSpace /\s\+$\|　/

set whichwrap=b,s,h,l,<,>,[,]

" バッファ名をGNU ScreenのScreen名にする
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | silent! exe '!echo -n "k%\\"' | endif

" ruby magic comment を 自動追加
autocmd BufNewFile *.rb 0r ~/.vim/templates/rb.tpl
