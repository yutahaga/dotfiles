" Display & Information
set lines=25        " typical
set columns=90      " margin for 'number' and 'foldcolumn'
set cmdheight=1     " MacVim $VIM/gvimrc overwrites my .vimrc settings
set guioptions=c    " show no GUI components


" Font
if has('unix')
  set guifont=M+\ 1m\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11,Myrica\ M\ 11
else
  set guifont=M+\ 1m\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11,Myrica\ M:h11
end
if has('kaoriya')
  set ambiwidth=auto
endif

" Turn off disabling IM at entering input mode
if exists('&imdisableactivate')
    set noimdisableactivate
endif