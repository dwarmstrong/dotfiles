#NAME=".bashrc"
#BLURB="~/.bashrc: executed by bash(1) for non-login shells"
#SOURCE="https://github.com/vonbrownie/dotfiles/blob/master/.bashrc"

# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples.

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

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below).
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color).
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt.
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

# Prompt colour codes
BLACK="\[\e[1;30m\]"
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
YELLOW="\[\e[1;33m\]"
BLUE="\[\e[1;34m\]"
MAGENTA="\[\e[1;35m\]"
CYAN="\[\e[1;36m\]"
WHITE="\[\e[1;37m\]"
RESET="\[\e[0m\]"

# Set a two-line prompt; if accessing via ssh include 'ssh-session' message.
if [[ -n "$SSH_CLIENT" ]]; then
    ssh_message="-ssh_session"
fi
if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="${debian_chroot:+($debian_chroot)}${MAGENTA}\u ${WHITE}at ${GREEN}\h${YELLOW}${ssh_message} ${WHITE}in ${BLUE}\w \n$WHITE\$${RESET} "
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

# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias lss='ls -aFlhv --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# More aliases and functions.
alias aaa="sudo apt update && apt list --upgradable && sudo apt full-upgrade && sudo apt autoremove"
alias arst="setxkbmap us && ~/bin/keyboardconf"
alias asdf="setxkbmap us -variant colemak && ~/bin/keyboardconf"
bak() { for f in "$@"; do cp "$f" "$f.$(date +%FT%H%M%S).bak"; done; }
alias dff="df -hT --total"
alias dmesg="sudo dmesg"
alias dpkgg="dpkg -l | grep -i"
alias earthview="streamlink http://www.ustream.tv/channel/iss-hdev-payload best &"
alias freee="free -h"
alias gpush="git push -u origin master"
alias gsave="git commit -m 'save'"
alias gs="git status"
alias histg="history | grep"
alias lsblkk="lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,UUID"
alias mkdirr="mkdir -pv"
mtg() { for f in "$@"; do mv "$f" "${f//[^a-zA-Z0-9\.\-]/_}"; done; }
alias pgrepp="pgrep -a"
alias poweroff="systemctl poweroff"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias reboot="systemctl reboot"
alias bye="sudo /sbin/shutdown"
alias tmuxd="tmux -f ~/.tmux.default attach"
alias yta="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --restrict-filenames"
alias zzz="sync && systemctl suspend"

# Colored GCC warnings and errors.
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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
    keychain ~/.ssh/id_ed25519
    . ~/.keychain/$HOSTNAME-sh
fi

# Disable XON/XOFF flow control. Enables the use of C-S in other commands.
# Example: forward search in history, and disabling screen freeze in vim.
stty -ixon
