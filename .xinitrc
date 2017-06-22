#!/bin/sh
# NAME=".xinitrc"
# BLURB="Read by xinit and by its front-end startx"
# SOURCE="https://github.com/vonbrownie/dotfiles/blob/master/.xinitrc"

#export QT_QPA_PLATFORMTHEME="qt5ct"

# Set config parameters for X client applications
if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi

# Bind commands to certain keys or key combos
if [ -f ~/.xbindkeysrc ]; then
    xbindkeys
fi

# Modify key mappings
if [ -f ~/.xmodmap ]; then
    xmodmap ~/.xmodmap
fi

# Disable DPMS and turn off screen blanking
xset s off -dpms

# Janitor
if [ -d ~/.local/share/Trash ]; then
    rm -rf ~/.local/share/Trash/*
fi

# Launch applications
~/bin/dldsply -r &
~/bin/trackpointconf &
if [ -x /usr/bin/nm-applet ]; then
    nm-applet &
fi
volnoti -t 2 &
urxvt &

# Start window manager
exec i3
