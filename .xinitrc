#!/bin/sh
# NAME=".xinitrc"
# BLURB="Read by xinit and by its front-end startx"
# SOURCE="https://github.com/vonbrownie/dotfiles/blob/master/.xinitrc"

#export QT_QPA_PLATFORMTHEME="qt5ct"

# Set config parameters for X client applications
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Bind commands to certain keys or key combos
[ -f ~/.xbindkeysrc ] && xbindkeys

# Modify key mappings
[ -f ~/.xmodmap ] && xmodmap ~/.xmodmap

# Disable DPMS and turn off screen blanking
xset s off -dpms

# Janitor
[ -d ~/.local/share/Trash ] && rm -rf ~/.local/share/Trash/*

# Applications
~/bin/dldsply -l &
~/bin/trackpointconf &
[ -x /usr/bin/nm-applet ] && nm-applet &
volnoti -t 2 &
urxvt &

# Start window manager
exec i3
