if [ "$(uname)" = 'Darwin' ]; then
  export LSCOLORS=xbfxcxdxbxegedabagacad
  alias ls='ls -G'
else
  eval `dircolors ${HOME}/.colorrc`
  alias ls='ls --color=auto --show-control-chars'
fi
alias la="ls -a"
alias tree="tree -I '.git'"
alias mkdir="mkdir -p"
alias e="$EDITOR"

# vim-less
alias less="${VIMRUNTIME}/macros/less.sh"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Git
alias gitsubup="git submodule foreach 'git pull origin master'"
alias repoinit="git init --bare --shared=true"

# Loading local aliases
if [ -f "${HOME}/.bash_aliases.local" ]; then
  source "${HOME}/.bash_aliases.local"
fi
