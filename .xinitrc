#!/bin/sh

# ~/.xinitrc ... used by X sessions started by xinit (startx)

export QT_QPA_PLATFORMTHEME="qt5ct"

# Set config parameters for X client applications
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Bind commands to certain keys or key combos
[ -f ~/.xbindkeysrc ] && xbindkeys

# Modify key mappings
[ -f ~/.xmodmap ] && xmodmap ~/.xmodmap

# Janitor
[ -d ~/.local/share/Trash ] && rm -rf ~/.local/share/Trash/*

# Applications
~/bin/dldsply &
~/bin/xtra &
urxvt &

# Start window manager
exec i3
