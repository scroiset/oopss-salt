
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='\u@\h:\w\$ '

# Configure shell history.
HISTCONTROL=ignoreboth
shopt -s histappend

# Add useful and common aliases.
alias ls='ls --color=auto'
alias ll="ls -l"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Specify PostgreSQL host.
export PGHOST="127.0.0.1"

