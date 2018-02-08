#NAME=".bashrc"
#BLURB="~/.bashrc: executed by bash(1) for non-login shells"
#SOURCE="https://github.com/vonbrownie/dotfiles/blob/master/.bashrc"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Unlimited history.
HISTSIZE=
HISTFILESIZE=

# Change the history file location because certain bash sessions truncate
# ~/.bash_history upon close.
HISTFILE=~/.bash_unlimited_history

# Default is to write history at the end of each session, overwriting the
# existing file with an updated version. If logged in with multiple sessions,
# only the last session to exit will have its history saved.
#
# Have prompt write to history after every command and append to the history
# file, don't overwrite it.
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Add a timestamp per entry. Useful for context when viewing logfiles.
HISTTIMEFORMAT="%FT%T  "

# Save all lines of a multiple-line command in the same history entry.
shopt -s cmdhist

# Reedit a history substitution line if it failed.
shopt -s histreedit

# Edit a recalled history line before executing.
shopt -s histverify

# Don't put lines starting with space in the history.
HISTCONTROL=ignorespace

# Toggle history off/on for a current shell.
alias stophistory="set +o history"
alias starthistory="set -o history"

# Helpful!
# https://stackoverflow.com/questions/9457233/unlimited-bash-history
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Set a two-line prompt; adjust colour based on HOSTNAME; if accessing via ssh
# include 'ssh-session' message.
if [[ -n "$SSH_CLIENT" ]]; then
    ssh_message="-ssh_session"
fi
if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="${debian_chroot:+($debian_chroot)}\[\e[35;1m\]\u \[\e[37;1m\]at \[\e[32;1m\]\h\[\e[33;1m\]${ssh_message} \[\e[37;1m\]in \[\e[34;1m\]\w \n\[\e[37;1m\]\$\[\e[0m\] "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls -aFlhv --color=auto"
    alias diff="colordiff"
    alias dir="dir --color=auto"
    alias vdir="vdir --color=auto"
    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# More aliases and functions.
alias aaa="generatePkgList -d ~/code/debian && sudo apt update && apt list --upgradable && sudo apt full-upgrade && sudo apt autoremove"
alias arst="setxkbmap us && ~/bin/keyboardconf"
alias asdf="setxkbmap us -variant colemak && ~/bin/keyboardconf"
bak() { for f in "$@"; do cp "$f" "$f.$(date +%FT%H%M%S).bak"; done; }
alias df="df -hT --total"
alias dmesg="sudo dmesg"
alias dpkgg="dpkg -l | grep -i"
alias earthview="streamlink http://www.ustream.tv/channel/iss-hdev-payload best &"
alias free="free -h"
alias gpush="git push -u origin master"
alias gsave="git commit -m 'save'"
alias gs="git status"
alias histg="history | grep"
alias mkdir="mkdir -pv"
mtg() { for f in "$@"; do mv "$f" "${f//[^a-zA-Z0-9\.\-]/_}"; done; }
alias pgrep="pgrep -a"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias reboot="sudo /sbin/reboot"
alias tmuxd="tmux -f ~/.tmux.default attach"
alias zzz="sync && systemctl suspend"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Setup keychain for ssh-agent management.
if [ -x /usr/bin/keychain ]; then
    keychain ~/.ssh/id_rsa
    . ~/.keychain/$HOSTNAME-sh
fi

# Disable XON/XOFF flow control. Enables the use of C-S in other commands.
# Example: forward search in history, and disabling screen freeze in vim.
stty -ixon

# UPDATE: Do *not* do this ... messes with tmux and htop and back color erase.
###Set TERM to make urxt and ssh sessions play nice and squash problems like
###"'rxvt-unicode-256color': unknown terminal type."
###export TERM='xterm-256color'

# Use qt5ct to configure theme in Qt5 and set environment variable so that
# the settings are picked up by Qt apps.
[[ -x "/usr/bin/qt5ct" ]] && export QT_QPA_PLATFORMTHEME=qt5ct

# Set cursor colour
if [ -t 1 ]; then
    echo -e "\e]12;red\a"
fi
