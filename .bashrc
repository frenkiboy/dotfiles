# .bashrc

######################################################################
## This file includes some minor changes to my non-login bash shell ##
######################################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

## Alias

# General Aliases

alias bget='wget --background'
alias c="clear"
alias dater="date +%y%m%d"
alias gp='guixr package'
alias ds='du -sh'
alias dss="ls | xargs du -sh"

alias l="ls -lh"
alias la="ls -lha"
alias lsd="ls -lhd */"
alias ls='ls -FG'
alias ll='ls -aFGlh'
alias mdkir="mkdir"
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color="auto"'
alias q="qstat -u vfranke"
alias R="/usr/bin/R"
alias pp='perl -pi -e "s|net|de|"'
alias rename="$MYLIB/Perl/r"
alias scd="cd"
alias sbr="source ~/.bashrc"
alias sl="ls"
alias setpath="pwd >> /.paths"
alias tt="tmux a -t"
alias wcl="wc -l"
alias gg='guixr'
alias ggp='guixr package'
alias zcat="gunzip -c"

alias beast="ssh beast.mdc-berlin.net"
alias cheku="ssh 141.80.186.199"
alias galaxy="ssh galaxy-dev.mdc-berlin.net"
alias max='ssh max-login'
alias shiny='ssh shiny.mdc-berlin.net'
alias static="ssh vfranke@bimsbstatic.mdc-berlin.net"


## use git repo for tracking dotfiles (https://www.atlassian.com/git/tutorials/dotfiles)
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 
alias dfs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 

## Functions

### add pyclean function
pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

## Folders

## Ssh

## Jupiter Notebook
function runJupiter {
	echo "starting chromium with proxy setup"
	chromiumProxy
	echo "please start jupiter on beast using:"
	echo "jupyter notebook --no-browser --port 8765"
	sleep 1
	echo "opening proxy port"
	openPort
}


## Bash History

# HISTCONTROL=ignoreboth:erasedups 
# HISTIGNORE="ls:clear:bg:fg:history:exit:pwd:cd\ ..:..:...:history\ *"
HISTTIMEFORMAT="%F %T " 
shopt -s histappend
#PROMPT_COMMAND='$PROMPT_COMMAND;history -a'
HISTFILESIZE=100000 
HISTSIZE=100000

## Add to PATH
export PATH="/Users/agosdsc/bin:$PATH"

## Bash completion
# after doing: brew install bash-completion 
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

## Git completion
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bas
# mv ~/.git-completion.bash /usr/local/etc/bash_completion.d/
if [ -f /usr/local/etc/bash_completion.d/.git-completion.bash ]; then
  . /usr/local/etc/bash_completion.d/.git-completion.bash
fi

## Powerline-style Bash prompt (https://github.com/riobard/bash-powerline)
# curl https://raw.githubusercontent.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh
source ~/.bash-powerline.sh


