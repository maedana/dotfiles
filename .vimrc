"==<etc>======================================================================
" vi互換機能オフ
set nocompatible
" バックアップを作らない
set nobackup
" swpファイルを作成するディレクトリを固定
set directory=/home/maedana/tmp
" vim開始時の挨拶を表示しない
set shortmess+=I
" 行番号表示
set number
" メッセージ表示に使う行数
set cmdheight=1
" バッファ放棄時にhidden状態になる
set hidden
" コマンド保存数
set history=100
" backspaceキーを使えるようにする 
set backspace=indent,eol,start
" mouse mode
set mouse=a
set ttymouse=xterm2
" folding
set foldmethod=indent
set foldlevel=1
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

filetype plugin on
filetype indent on

"==<tabkey>===================================================================
set cindent
set expandtab

autocmd BufEnter * call SetTab()

function! SetTab()
  if &syntax == 'ruby' || &syntax == 'python' || &syntax == 'html' || &syntax == 'xhtml' || &syntax == 'css' || &syntax == 'eruby' || &syntax == 'yaml' || &syntax == 'vim' || &syntax == 'haml' || &syntax == 'sass' || &syntax == 'xml'
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

autocmd FileType cvs :set fileencoding=euc-jp
autocmd FileType svn :set fileencoding=utf-8

"==<svk>======================================================================
au BufNewFile,BufRead svk-commit*.tmp setf svk

"==<comlete>==================================================================
" omni complete
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType html :set filetype=xhtml
autocmd Filetype html :set omnifunc=htmlcomplete#CompleteTags

"Rubyのオムニ補完を設定(ft-ruby-omni)
"let g:rubycomplete_buffer_loading = 1
"let g:rubycomplete_classes_in_global = 1
"let g:rubycomplete_rails = 1

" omni completeをTabキーで出来るようにする
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

"==<head comment>=============================================================
"iab papp <ESC>:r ~/.vim/templates/perl_application.pl<CR>
"iab ppkg <ESC>:r ~/.vim/templates/perl_package.pl<CR>
"iab pcls <ESC>:r ~/.vim/templates/perl_class.pl<CR>
"iab psub <ESC>:r ~/.vim/templates/perl_subroutine.pl<CR>

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

"==<plugin>=================================================================
"==rails.vim
let g:rails_level = 4
let g:rails_defalut_database = 'sqlite3'
let g:rails_syntax=1
let g:rails_gnu_screen=1

"==surroud.vim
autocmd Syntax htmldjango let g:surround_37 = "{% \r %}"

"==yanktmp.vim(via id:secondlife
if v:version >= 700 
  let g:yanktmp_file = $HOME . '/.vimyanktmp'
  map <silent> sy :call YanktmpYank()<CR>
  map <silent> sp :call YanktmpPaste_p()<CR>
  map <silent> sP :call YanktmpPaste_P()<CR>
endif

"YankRing.vim (ver3.0) via http://www.graphact.com/memo/2007/12/13/168
set viminfo+=!

"hatena.vim
let g:hatena_user='maedana'

"==<vim-reading#04より>=================================================================
highlight ZenkakuSpace ctermbg=6
match ZenkakuSpace /\s\+$\|　/

set whichwrap=b,s,h,l,<,>,[,]

" insert timestamp
nmap tw :exe "normal! i" . strftime("%Y-%m-%d\T%H:%M:%S+09:00")<CR>

" バッファ名をGNU ScreenのScreen名にする
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | silent! exe '!echo -n "k%\\"' | endif
