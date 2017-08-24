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

# Janitor
[ -d ~/.local/share/Trash ] && rm -rf ~/.local/share/Trash/*

# Applications
~/bin/dldsply -r &
~/bin/i3wm_conf &
sleep 2
(sleep 15; ~/bin/keyboardconf) &
[ -x /usr/bin/cmst ] && cmst -m &
volnoti -t 2 &

# Start window manager
exec i3
