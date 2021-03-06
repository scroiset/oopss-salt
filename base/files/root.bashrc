# Managed by Salt

# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
umask 077

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Define different prompt colors depending of the environnement: dev/QA/prod.
if hostname | grep -E -- '-dev$' >/dev/null; then
    color="2"   # green
elif hostname | grep -E -- '-qa$' >/dev/null; then
    color="3"   # yellow
else
    color="9"   # red
fi
PS1="\[$(tput setaf $color)\]\u@$(hostname -f):\w\\$\[$(tput sgr0)\] "

# History control
shopt -s histappend
export HISTSIZE=65536
PROMPT_COMMAND='history -a'

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Fix Debian bug #770684 when launching lxc-start with restrictive umask
lxc-start() {
    umask 022
    /usr/bin/lxc-start $*
    umask 077
}

