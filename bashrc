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
source $HOME/.bashvars

shopt -s checkwinsize

# ------------------------------------- #
# aliases
alias beast="ssh beast.mdc-berlin.net"
alias cc="ssh 10.80.35.125"
alias bget='wget --background'
alias c="clear"
alias dater="date +%y%m%d"
alias envlist="conda env list"
alias gp='guixr package'
alias ds='du -sh'
alias dss="ls -a | tail -n +3 | xargs du -sh"
alias galaxy="ssh galaxy-dev.mdc-berlin.net"
alias hs="history | grep screen"
#alias java='/home/vfranke/bin/Software/Java/jre1.8.0_45/bin/java'
alias juwels="ssh franke6@juwels-booster.fz-juelich.de"
alias l="ls -lh"
alias la="ls -lha"
alias lsd="ls -lhd */"
alias lst="ls -t"
alias lstop="ls -t | head -n2"
alias login1="ssh 141.80.186.21"
alias max='ssh max-login'
alias tc="tar -cvf"
alias tz="tar -czvf"
alias tx="tar -xzvf"
alias md="mkdir Data Results Scripts"
alias mdkir="mkdir"
alias q="qstat -u vfranke"
alias guixenv='/gnu/var/guix/profiles/custom/r-for-beast/load-it.bash'
alias pp='perl -pi -e "s|net|de|"'
alias rename="$MYLIB/Perl/r"
alias R45="/opt/R/4.5/bin/R"
alias sambamba="/home/vfranke/bin/Software/Sambamba/sambamba_v0.4.7"
alias scd="cd"
alias sc="screen -rd"
alias sbr="source ~/.bashrc"
alias sl="ls"
alias sq="squeue"
alias setpath="pwd >> /.paths"
alias static="ssh vfranke@bimsbstatic.mdc-berlin.net"
alias tt="tmux a -t"
alias makeproj="$MYLIB/Bash/MakeBeastProject.sh"
alias wcl="wc -l"
alias cheku="ssh 141.80.186.199"
alias gg='guixr'
alias ggp='guixr package'
alias shiny='ssh shiny.mdc-berlin.net'
alias R4='/opt/R/4.0/bin/R --vanilla'
alias R4sto='/opt/R/4.0/bin/R'
alias R41='/opt/R/4.1/bin/R'
alias R42='/opt/R/4.2/bin/R'
alias lspace="df -h | grep local"
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

# ------------------------------------- #
# source
source $MYLIB/Bash/AccessoryFunctions.sh
source $MYLIB/Bash/MakeLinks.sh


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


# ------------------------------------- #
function makeRlink {

	ln -s /home/vfranke/bin/Packages/Mylib/R/$1 /home/vfranke/bin/MyLib/RFun/$1
}


# ------------------------------------- #
function makebwlinks {
        dir=`pwd`
	prefix='http://bimsbstatic.mdc-berlin.de/akalin'
        name=`echo $dir | perl -pe "s|^.+akalin||"`
         if [ -e links.txt ];then
                 rm links.txt
         fi
         for i in `ls $dir | grep -v links.txt`;do
         filename=`basename $i .bw`
         echo $i | perl -pne "s|^|track type=bigWig name=\"$filename\" bigDataUrl=$prefix/$name/|" | perl -pe 's|$|"|;s|Url=|Url="|'  >> links.txt
         done

 }


function gitprompt {
    source /home/vfranke/bin/Software/Bash/git-prompt/git-prompt
}

function changepath {
	export PATH='/usr/local/bin:/usr/bin'
	export PATH="$HOME/.local/bin:$PATH"
}


function condapath {
	changepath

# 	__conda_setup="$('/home/vfranke/bin/Software/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# 	if [ $? -eq 0 ]; then
# 	    eval "$__conda_setup"
# 	else
# 	if [ -f "/home/vfranke/bin/Software/miniconda3/etc/profile.d/conda.sh" ]; then
# # . "/home/vfranke/bin/Software/miniconda3/etc/profile.d/conda.sh" e  # commented out by conda initialize
# 	else
# 		export PATH="/home/vfranke/bin/Software/miniconda3/bin:$PATH" 
# 	fi
# 	fi
# 	unset __conda_setup
    __conda_setup="$('/home/vfranke/bin/mamba/miniforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/vfranke/bin/mamba/miniforge/etc/profile.d/conda.sh" ]; then
            . "/home/vfranke/bin/mamba/miniforge/etc/profile.d/conda.sh"
        else
            export PATH="/home/vfranke/bin/mamba/miniforge/bin:$PATH"
        fi
    fi
    unset __conda_setup

    if [ -f "/home/vfranke/bin/mamba/miniforge/etc/profile.d/mamba.sh" ]; then
        . "/home/vfranke/bin/mamba/miniforge/etc/profile.d/mamba.sh"
    fi

}

# direnv hook
eval "$(direnv hook bash)"

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
