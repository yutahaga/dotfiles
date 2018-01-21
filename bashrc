# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# ~/.bashrc: executed by bash(1) for interactive shells.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the msys2 mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Use bash-completion, if available
if [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
elif [[ $PS1 && -f /usr/local/etc/bash_completion ]]; then
  . /usr/local/etc/bash_completion
fi

# Some people use a different file for prompt
[[ -f "${HOME}/.bash_prompt" ]] && . "${HOME}/.bash_prompt"

# Some people use a different file for aliases
[[ -f "${HOME}/.bash_aliases" ]] && . "${HOME}/.bash_aliases"

# Percol/Peco's settings
PIPETOOL=false
if hash percol 2>/dev/null ; then
  PIPETOOL=percol
elif hash peco 2>/dev/null ; then
  PIPETOOL=peco
fi
if [[ -n "${PIPETOOL}" ]]; then
  _replace_by_history() {
    local l=$(HISTTIMEFORMAT= history | tac | sed -e 's/^\s*[0-9]\+\s\+//' | ${PIPETOOL} --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
  }
  bind -x '"\C-r": _replace_by_history'
  bind    '"\C-xr": reverse-search-history'

  _cd_cdhist() {
    cd "$(for i in "${CDHIST_CDQ[@]}"; do echo $i; done | ${PIPETOOL})"
  }
  bind '"\C-xj": "_cd_cdhist\n"'

  _select_gitdir() {
    find "${WORKING_DIR}" -maxdepth 3 -type d -a -name '.git' | \
      sed -e 's@/.git@/@' | \
      $PIPETOOL
  }

  _cd_gitdir() {
    cd "$(_select_gitdir)"
  }
  bind '"\C-xg": "_cd_gitdir\n"'

  _insert_gitdir() {
    local l=$(_select_gitdir)
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${l}${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(($READLINE_POINT + ${#l}))
  }
  bind -x '"\C-x\C-g": _insert_gitdir'
fi

#
# Plugins
#

# BASH_PLUGINS="${HOME}/.cache/bash/plugins"
# [[ ! -d "${BASH_PLUGINS}" ]] && mkdir -p "${BASH_PLUGINS}"

# b4b4r07/enhancd (too slow!)
# [[ ! -f "${BASH_PLUGINS}/enhancd.sh" ]] && \
#   curl -f -S "https://raw.githubusercontent.com/b4b4r07/enhancd/master/enhancd.sh" > "${BASH_PLUGINS}/enhancd.sh"
# . "${BASH_PLUGINS}/enhancd.sh"