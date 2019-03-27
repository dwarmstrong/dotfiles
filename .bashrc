# ~/.bashrc
#
# Source: https://github.com/vonbrownie/dotfiles/blob/master/.bashrc

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# == Prompt ==

# colour codes
BLACK="\[\e[1;30m\]"
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
YELLOW="\[\e[1;33m\]"
BLUE="\[\e[1;34m\]"
MAGENTA="\[\e[1;35m\]"
CYAN="\[\e[1;36m\]"
WHITE="\[\e[1;37m\]"
RESET="\[\e[0m\]"

# set a two-line prompt; if accessing via ssh include 'ssh-session' message.
if [[ -n "$SSH_CLIENT" ]]; then
    ssh_message="-ssh_session"
fi
PS1="${MAGENTA}\u ${WHITE}at ${GREEN}\h${YELLOW}${ssh_message} ${WHITE}in ${BLUE}\w \n$WHITE\$${RESET} "
#PS1='[\u@\h \W]\$ '

# == Functions ==

bak() { for f in "$@"; do cp "$f" "$f.$(date +%FT%H%M%S).bak"; done; }
mtg() { for f in "$@"; do mv "$f" "${f//[^a-zA-Z0-9\.\-]/_}"; done; }

# == Aliases ==

alias aaa="sudo apt update && apt list --upgradable && sudo apt full-upgrade && sudo apt autoremove"
alias arst="setxkbmap us && ~/bin/keyboardconf"
alias asdf="setxkbmap us -variant colemak && ~/bin/keyboardconf"
alias bye="sudo systemctl poweroff"
alias dff="df -hT --total"
alias dpkgg="dpkg -l | grep -i"
alias earthview="streamlink http://www.ustream.tv/channel/iss-hdev-payload best &"
alias gpush="git push -u origin master"
alias gsave="git commit -m 'save'"
alias gs="git status"
alias l='ls -aFlhNv --color=auto'
alias lsblkk="lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,UUID"
alias mkdirr="mkdir -pv"
alias p="less"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias reboot="sudo systemctl reboot"
alias tmuxd="tmux -f ~/.tmux.default attach"
alias yta="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --restrict-filenames"
alias zzz="sync && sudo systemctl suspend"

if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi

# == History ==

# unlimited history.
HISTSIZE=
HISTFILESIZE=

# change the history file location because certain bash sessions truncate
# ~/.bash_history upon close.
HISTFILE=~/.bash_unlimited_history

# default is to write history at the end of each session, overwriting the
# existing file with an updated version. If logged in with multiple sessions,
# only the last session to exit will have its history saved.
#
# have prompt write to history after every command and append to the history
# file, don't overwrite it.
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# ... then you can see the commands from all shells in near real-time
# in ~/.bash_unlimited history. Starting a new shell displays the
# combined history from all terminals.

# add a timestamp per entry. Useful for context when viewing logfiles.
HISTTIMEFORMAT="%FT%T  "

# save all lines of a multiple-line command in the same history entry.
shopt -s cmdhist

# reedit a history substitution line if it failed.
shopt -s histreedit

# edit a recalled history line before executing.
shopt -s histverify

# don't put lines starting with space in the history.
HISTCONTROL=ignorespace

# toggle history off/on for a current shell.
alias stophistory="set +o history"
alias starthistory="set -o history"

# Helpful!
# https://superuser.com/q/575479
# https://unix.stackexchange.com/q/1288

# == Misc ==

# when resizing a terminal emulator, check the window size after each command
# and, if necessary, update the values of LINES and COLUMNS. 
shopt -s checkwinsize

# *pkgfile* includes a "command not found" hook that will automatically search
# the official repositories, when entering an unrecognized command
if [[ -a /usr/share/doc/pkgfile/command-not-found.bash ]]; then
	source /usr/share/doc/pkgfile/command-not-found.bash
fi

# keychain for ssh-agent management
if [[ -x /usr/bin/keychain ]]; then
	eval $(keychain --eval --quiet --noask id_ed25519)
fi

# disable XON/XOFF flow control. Enables the use of C-S in other commands.
# example: forward search in history, and disabling screen freeze in vim.
stty -ixon
