#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

command -v git >/dev/null 2>&1 ||
{ echo >&2 "Git is not installed. Installing..";
  sudo pacman -S git
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\e[32m\]\u@\h \e[34m\]\W\e[37m\]$(bashrc-git-branch)]\e[32m\]\$\e[37m\] '

. "$HOME/.cargo/env"
source /usr/share/nvm/init-nvm.sh
export PATH=/home/bjorn/.scripts:/home/bjorn/.nvm/versions/node/v20.15.0/bin:/home/bjorn/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/bjorn/.garden/bin

# add Pulumi to the PATH
export PATH=$PATH:/home/bjorn/.pulumi/bin
