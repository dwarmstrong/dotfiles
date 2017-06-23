# NAME=".bashrc"
# BLURB="~/.bashrc: executed by bash(1) for non-login shells"
# SOURCE="https://github.com/vonbrownie/dotfiles/blob/master/.bashrc"

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

# Automatically prepend cd when entering just a path in the shell.
shopt -s autocd

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability.
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
if [ "$color_prompt" = yes ]; then
    if [[ -n "$SSH_CLIENT" ]]; then
        ssh_message=": ssh-session"
    fi
    if [[ $HOSTNAME = "nuu"* ]] || [[ $HOSTNAME = "ull"* ]]; then
        PS1="\[\e[32;1m\]:(\[\e[37;1m\]\u@\h\[\e[33;1m\]${ssh_message}\[\e[32;1m\])-(\[\e[34;1m\]\w\e[32;1m\])\n:.(\[\e[37;1m\]\!\[\e[32;1m\])-\[\e[37;1m\]\$\[\e[0m\] "
    else
        PS1="\[\e[32;1m\]:(\[\e[31;1m\]\u@\h\[\e[33;1m\]${ssh_message}\[\e[32;1m\])-(\[\e[34;1m\]\w\e[32;1m\])\n:.(\[\e[31;1m\]\!\[\e[32;1m\])-\[\e[37;1m\]\$\[\e[0m\] "
    fi
else
    PS1="\u@\h:\w\$ "
fi
unset color_prompt force_color_prompt

# Enable color support of ls and a few handy aliases.
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

# More aliases and functions.
alias ..="cd .."
alias aaa="sudo apt update && apt list --upgradable && sudo apt full-upgrade"
alias arst="setxkbmap us"
alias asdf="setxkbmap us -variant colemak"
bak() { for f in "$@"; do cp "$f" "$f.$(date +%FT%H%M%S).bak"; done; }
alias df="df -hT --total"
alias dmesg="sudo dmesg"
alias dpkgg="dpkg -l | grep -i"
dsrt() { du -ach $1 | sort -h; }
alias free="free -h"
alias gpush="git push -u origin master"
alias gsave="git commit -m 'save'"
alias gs="git status"
alias histg="history | grep"
alias lsl="ls | less"
alias mkdir="mkdir -pv"
mcd() { mkdir -p $1; cd $1; } 
mtg() { for f in "$@"; do mv "$f" "${f//[^a-zA-Z0-9\.\-]/_}"; done; }
alias pgrep="pgrep -a"
alias poweroff="sudo /sbin/poweroff"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"
alias tmuxa="tmux -f $HOME/.tmux.default.conf attach"
alias wget="wget -c"
alias zzz="sync && systemctl suspend"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features (you don't need to enable
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

# Add directories to my $PATH.
export PATH=$PATH:/sbin

# Disable XON/XOFF flow control. Enables the use of C-S in other commands.
# Example: forward search in history, and disabling screen freeze in vim.
stty -ixon
