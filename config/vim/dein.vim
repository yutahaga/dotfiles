"------------------------------------------------------------------
" dein
"

let s:dein_config = $CONFIG . '/dein'
let s:dein_dir = $CACHE . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath+=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:dein_config .'/plugins.toml', {'lazy': 0})
  call dein#load_toml(s:dein_config .'/plugins_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if has('vim_starting') && dein#check_install()
  call dein#install()
endif