#!/bin/sh
# NAME=".xinitrc"
# BLURB="Read by xinit and by its front-end startx"
# SOURCE="https://github.com/vonbrownie/dotfiles/blob/master/.xinitrc"
# HOMEBIN_SOURCE="https://github.com/vonbrownie/homebin"

# --------[ Handled by keyboardconf ]---------------------------------------- #

# Bind commands to certain keys or key combos
#[ -f ~/.xbindkeysrc ] && xbindkeys

# Key mappings
#[ -f ~/.xmodmap ] && xmodmap ~/.xmodmap

# --------------------------------------------------------------------------- #

# Config parameters for X client applications
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Disable DPMS and turn off screen blanking
xset s off -dpms

# Disable system beep
xset b off

# Set keyboard layout to colemak
setxkbmap -model pc105 -layout us -variant colemak

# Start the gnome-keyring-daemon
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK

# Janitor
[ -d ~/.local/share/Trash ] && rm -rf ~/.local/share/Trash/*

# Applications
~/bin/dldsply -r &
~/bin/i3wm_conf &
sleep 2
(sleep 15; ~/bin/keyboardconf) &
#[ -x /usr/bin/nm-applet ] && nm-applet &
#[ -x /usr/bin/wicd-client ] && wicd-client --tray &

# Start window manager
exec i3
