"------------------------------------------------------------------
" Plugin 
"

if &compatible
  set nocompatible
endif

let $CONFIG = (empty($XDG_CONFIG_HOME) ? expand('~/.config') : expand($XDG_CONFIG_HOME)) . '/vim'

function! s:source_rc(path, ...) abort
  let use_global = get(a:000, 0, !has('vim_starting'))
  let abspath = resolve(expand($CONFIG . '/' . a:path))
  if !use_global
    execute 'source' fnameescape(abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let content = map(readfile(abspath),
        \ 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')
  " create tempfile and source the tempfile
  let tempfile = tempname()
  try
    call writefile(content, tempfile)
    execute printf('source %s', fnameescape(tempfile))
  finally
    if filereadable(tempfile)
      call delete(tempfile)
    endif
  endtry
endfunction

" Set augroup
augroup MyAutoCmd
  autocmd!
augroup END

if has('vim_starting')
  call s:source_rc('init.vim')
endif

" dein settings
call s:source_rc('dein.vim')

execute 'set runtimepath+=' . $CONFIG

filetype plugin indent on


"------------------------------------------------------------------
" System 
"

" Backup settings
set nobackup
set writebackup
execute 'set backupdir=' . $CACHE . '/backup'
set swapfile
execute 'set directory=' . $CACHE . '/swap'
set undofile
execute 'set undodir=' . $CACHE . '/undo'

" Encoding settings
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
if IsWindows()
  if has('gui_running')
    let &termencoding = &encoding
    set encoding=utf-8
  else
    set encoding=cp932
  endif
endif

" File settings
set confirm
set hidden
set autoread
set browsedir=buffer

" Sound settings
set noerrorbells
set novisualbell
set visualbell t_vb=

" History settings
set history=100

" Completion settings
set infercase
set wildmenu
set wildmode=list:longest,full

" Misc settings
set virtualedit+=block


"------------------------------------------------------------------
" Appearance
"

call s:source_rc('appearance.vim')


"------------------------------------------------------------------
" Find & Replace 
"

set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan
set gdefault


"------------------------------------------------------------------
" Edit 
"

" Clipboard setting
set clipboard=unnamed

" Indent settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set shiftround
set expandtab
set autoindent
set smartindent

" Backspace setting
set backspace=indent,eol,start

" Move the cursor across the line
set whichwrap=b,s,h,l,<,>,[,]

" <F5>: toggle paste mode
imap <F5> <nop>
set pastetoggle=<F5>

" Timeout settings
set notimeout
set ttimeout
set timeoutlen=100


"------------------------------------------------------------------
" for Cygwin
"

"let s:is_windows =  has('win16') || has('win32') || has('win64')
"let s:is_cygwin  =  has('win32unix')
"let s:is_cui     = !has('gui_running')

"if s:is_cygwin
"  if &term !=# 'cygwin'  " not in command prompt
    " Change cursor shape depending on mode
"    let &t_ti .= "\e[1 q"
"    let &t_SI .= "\e[5 q"
"    let &t_EI .= "\e[1 q"
"    let &t_te .= "\e[0 q"
"  endif
"endif

"if !s:is_windows && s:is_cui
"  for s:ch in map(
"        \   range(char2nr('a'), char2nr('z'))
"        \ + range(char2nr('A'), char2nr('N'))
"        \ + range(char2nr('P'), char2nr('Z'))
"        \ + range(char2nr('0'), char2nr('9'))
"        \ , 'nr2char(v:val)')
"    exec 'nmap <ESC>' . s:ch '<M-' . s:ch . '>'
"  endfor
"  unlet s:ch
"  map  <NUL>  <C-Space>
"  map! <NUL>  <C-Space>
"endif


"-------------------------------------------------------------------------------
" Key map
"-------------------------------------------------------------------------------
"    map:キーシーケンスを展開したあと、さらに別のマップを適用
"noremap:一度だけ展開
"-------------------------------------------------------------------------------
" コマンド         ノーマル    インサート   コマンドライン      ビジュアル
" map/noremap         @            -              -                  @
" map!/noremap!       -            @              @                  -
" nmap/nnoremap       @            -              -                  -
" imap/inoremap       -            @              -                  -
" cmap/cnoremap       -            -              @                  -
" vmap/vnoremap       -            -              -                  @
"


"---------------------------------------
" Prefix
nnoremap [space]  <Nop>
nmap     <Space>  [space]
xmap     <Space>  [space]

nnoremap [Window]        <Nop>
nmap     <Space>w        [Window]

nnoremap [Tag]           <Nop>
nmap     <Space>t        [Tag]

nnoremap [unite]         <Nop>
nmap     <Space>u        [unite]

nnoremap [vimfiler]      <Nop>
nmap     <Space>f        [vimfiler]


"---------------------------------------
" uniteマッピング

"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> [unite]m :Unite file_mru<CR>
" ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
" ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
augroup vimrc
  autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings()
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "sでsplit
  nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  "vでvsplit
  nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  "fでvimfiler
  nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
endfunction


"---------------------------------------
" VimFilerマッピング

"現在開いているバッファのディレクトリを開く
nnoremap <silent> [vimfiler]e :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> [vimfiler]i :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
 
"デフォルトのキーマッピングを変更
augroup vimrc
  autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
  nmap <buffer> q <Plug>(vimfiler_exit)
  nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction


"---------------------------------------
" cawマッピング
"---------------------------------------
" Ctrl+/ でコメントアウトの切り替え
nmap <C-_> <Plug>(caw:i:toggle)
vmap <C-_> <Plug>(caw:i:toggle)


"---------------------------------------
" vimrc編集/反映
nnoremap [space]v :<C-u>tabedit $MYVIMRC<CR>
nnoremap [space]g :<C-u>tabedit $MYGVIMRC<CR>
nnoremap [space]s :<C-u>source $MYVIMRC<CR>
                     \ :source $MYGVIMRC<CR>

"--------------------------------------
" <C-j> → <Esc>
imap <C-j> <Esc>

"---------------------------------------
" 十字キーの異常を修正 
imap ^[OA <Up>
imap ^[OB <Down>
imap ^[OC <Right>
imap ^[OD <Left>

"---------------------------------------
" 挿入モードでカーソルキーがABCDになるのを回避
inoremap ^[OD <Left>    
inoremap ^[OB <Down>
inoremap ^[OA <Up>
inoremap ^[OC <Right>


"---------------------------------------
" インサートから抜けたら、IME解除
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>


"---------------------------------------
" 全角スペース表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=darkgreen gui=reverse guifg=darkgreen
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme                * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead  * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif


"---------------------------------------
" タブページ用
" 以下のサイトからの転用
" http://qiita.com/wadako111/items/755e753677dd72d8036d
" ---
" tp : 前のタブ
" tt : 次のタブ
" t1, t2,,,t9 : 左からn番目のタブにジャンプ
" tn : 新しいタブ
" tx : タブを閉じる
" ---
" ----- 転用ここから（一部変更） -----
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
"nnoremap    [Tag]   <Nop>
"nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]n :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]t :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
" ----- 転用ここまで -----

"---------------------------------------
" window操作用
" wn  : 垂直分割（新規）
" ws  : 垂直分割（今のファイル）
" wvn : 水平分割（新規）
" wvs : 水平分割（今のファイル）
" <C-W>w : 次のウィンドウに移動
" <C-W>p : 前のウィンドウに移動
" <C-W>h : 左のウィンドウに移動
" <C-W>j : 下のウィンドウに移動
" <C-W>k : 上のウィンドウに移動
" <C-W>l : 右のウィンドウに移動
" <C-W>q : ウィンドウを閉じる

map <silent> [Window]n :new<CR>
map <silent> [Window]s :sp<CR>
map <silent> [Window]vn :vne<CR>
map <silent> [Window]vs :vs<CR>
"map <silent> [Window]w <C-W>w<CR>
"map <silent> [Window]p <C-W>p<CR>
"map <silent> [Window]h <C-W>h<CR>
"map <silent> [Window]j <C-W>j<CR>
"map <silent> [Window]k <C-W>k<CR>
"map <silent> [Window]l <C-W>l<CR>
"map <silent> [Window]x <C-W>q<CR>

nnoremap <silent> <S-Left>  <C-w>h<CR>
nnoremap <silent> <S-Down>  <C-w>j<CR>
nnoremap <silent> <S-Up>    <C-w>k<CR>
nnoremap <silent> <S-Right> <C-w>l<CR>

