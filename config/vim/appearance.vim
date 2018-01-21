"------------------------------------------------------------------
" Appearance
"

" Display settings
language C
set number
set ruler
set title
set display=uhex
set matchpairs& matchpairs+=<:>
set showmatch
set matchtime=1
set textwidth=0
set ambiwidth=double

" Status line settings
set laststatus=2
set cmdheight=2
set showcmd

" Highlight settings
syntax enable
set cursorline
set cursorcolumn
set colorcolumn=80

set t_Co=256
set background=dark

" Scroll settings
set scrolloff=5
set sidescrolloff=16
set sidescroll=1
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set nowrap

" ConEmu settings
if $CONEMUBUILD
  " Use ConEmu 256 color mode.
  " https://conemu.github.io/en/VimXterm.html
  set term=pcansi
  set t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"

  " Use mouse in ConEmu console.
  set mouse=a
  inoremap <Esc>[62~ <C-X><C-E>
  inoremap <Esc>[63~ <C-X><C-Y>
  nnoremap <Esc>[62~ <C-E>
  nnoremap <Esc>[63~ <C-Y>
endif
