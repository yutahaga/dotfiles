"------------------------------------------------------------------
" Initialize
"

let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !has('win32unix')
      \ && (has('mac') || has('macunix') || has('gui_macvim')
      \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

" Use English interface.
language message C

if IsWindows()
  " Exchange path separator.
   set shellslash
endif

let $CACHE = empty($XDG_CACHE_HOME) ? expand('~/.cache') : expand($XDG_CACHE_HOME)

if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

if !isdirectory(expand($CACHE . '/backup'))
  call mkdir(expand($CACHE . '/backup'))
endif

if !isdirectory(expand($CACHE . '/swap'))
  call mkdir(expand($CACHE . '/swap'))
endif

if !isdirectory(expand($CACHE . '/undo'))
  call mkdir(expand($CACHE . '/undo'))
endif

