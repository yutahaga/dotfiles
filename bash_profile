# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# ~/.bash_profile: executed by bash(1) for login shells.

# The copy in your home directory (~/.bash_profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the msys2 mailing list.

# User dependent .bash_profile file

# Locale
export LANG=ja_JP.UTF-8

# Term
export TERM=xterm-256color

# Editor
export EDITOR=vim

# Vim Runtime
[[ ! -f ${HOME}/.cache/bash/VIMRUNTIME ]] && mkdir -p ${HOME}/.cache/bash >/dev/null &&\
  vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>" | echo $VIMRUNTIME | quit' | tr -d '\015' 2>/dev/null > ${HOME}/.cache/bash/VIMRUNTIME
export VIMRUNTIME=$(cat "${HOME}/.cache/bash/VIMRUNTIME")

# User's binary
export PATH=${HOME}/bin:$PATH

# History
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups
export HISTIGNORE=?:??:exit
export HISTFILE=~/.bash_history/.bash_history-$OSTYPE-`date +%Y%m%d`

# XDG Base Directory
export XDG_CONFIG_HOME=${HOME}/.config

# Working directory
export WORKING_DIR="${HOME}/src"

# Go
export GOPATH=${HOME}/.go
export PATH=${GOPATH}/bin:$PATH

# Ruby
if [ -d "${HOME}/.rbenv" ]; then
  export PATH=${HOME}/.rbenv/bin:${PATH}
  eval "$(rbenv init -)"
elif [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "${HOME}/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]]; then
  source "/usr/local/rvm/scripts/rvm"
elif hash ruby 2>/dev/null ; then
  export PATH=${HOME}/.gem/ruby/$(ruby -e 'print(RUBY_VERSION)')/bin:$PATH
fi

# Node.js
if [ -d "${HOME}/.ndenv" ]; then
  export PATH=${HOME}/.ndenv/bin:${PATH}
  eval "$(ndenv init -)"
fi

# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ]; then
  source "${HOME}/.bashrc"
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/man" ]; then
  MANPATH="${HOME}/man:${MANPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH="${HOME}/info:${INFOPATH}"
# fi
