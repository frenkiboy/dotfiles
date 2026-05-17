# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200


test -s ~/.alias && . ~/.alias || true

# ------------------------------------- #
### ALL EXPORTS ARE IN ~/.bashvars
# variables
[ -f "$HOME/.bashvars" ] && source "$HOME/.bashvars"

shopt -s checkwinsize

# ------------------------------------- #
# aliases
alias bget='wget --background'
alias c="clear"
alias dater="date +%y%m%d"
alias ds='du -sh'
alias dss="ls -a | tail -n +3 | xargs du -sh"
alias l="ls -lh"
alias la="ls -lha"
alias lsd="ls -lhd */"
alias lst="ls -t"
alias lstop="ls -t | head -n2"
alias tc="tar -cvf"
alias tz="tar -czvf"
alias tx="tar -xzvf"
alias scd="cd"
alias sbr="source ~/.bashrc"
alias sl="ls"
alias sq="squeue"
alias setpath="pwd >> /.paths"
alias tt="tmux a -t"
alias wcl="wc -l"
alias yy="jupyter notebook --no-browser"
alias clauded="claude --dangerously-skip-permissions"
alias claudedc="claude --dangerously-skip-permissions --continue"


# ------------------------------------- #
# path variables
paths=~/.paths
if [ -e $paths ];
then
	PATHS=(`cat $paths`)
fi
PATH=`echo ${PATHS[@]} | sed 's|\s|:|g'`:"${PATH}":'/bin'



function setpath {
	export PATH='/usr/local/bin:/usr/bin'
}

# ------------------------------------- #
# functions for quic navigation
export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark





# direnv hook
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------------- #
# kanban: open the most recent kanban (lanes side-by-side in vim).
# Usage:
#   kanban              # most recent unified kanban (or its lane trio if present)
#   kanban <pattern>    # most recent kanban whose filename contains <pattern>
#                       # pattern can be a date (260505), project name, etc.
function kanban {
    local dir="$HOME/Utils"
    local pattern="${1:-}"
    local match
    if [ -n "$pattern" ]; then
        match=$(ls -1t "$dir"/kanban_*"$pattern"*.md 2>/dev/null | head -1)
    else
        match=$(ls -1t "$dir"/kanban_*.md 2>/dev/null | head -1)
    fi
    if [ -z "$match" ]; then
        echo "kanban: no file found in $dir matching '${pattern:-*}'" >&2
        return 1
    fi
    # Strip _todo / _wip / _done suffix to find the lane trio for the same date
    local base
    base=$(echo "$match" | sed -E 's/_(todo|wip|done)\.md$/.md/' | sed 's/\.md$//')
    if [ -f "${base}_todo.md" ] && [ -f "${base}_wip.md" ] && [ -f "${base}_done.md" ]; then
        vim -O "${base}_todo.md" "${base}_wip.md" "${base}_done.md"
    else
        vim "$match"
    fi
}

# ------------------------------------- #
# tmux session listings sorted by time
alias tls='tmux ls -F "#{t:session_activity}  #{session_name}  (#{session_windows} wins)" | sort -r'
alias tlc='tmux ls -F "#{t:session_created}  #{session_name}" | sort -r'
