#!/bin/sh
# NAME=".xinitrc"
# BLURB="Read by xinit and by its front-end startx"
# SOURCE="https://github.com/vonbrownie/dotfiles/blob/master/.xinitrc"

# Launch applications at `startx` listed in `~/.config/openbox/autostart

# Bind commands to certain keys or key combos
#[ -f ~/.xbindkeysrc ] && xbindkeys     # Managed by keyboardconf in autostart

# Key mappings
#[ -f ~/.xmodmap ] && xmodmap ~/.xmodmap    # Managed by keyboardconf

# Config parameters for X client applications
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Disable DPMS and turn off screen blanking
xset s off -dpms

# Disable system beep
xset b off

# Set keyboard layout to colemak
setxkbmap -model pc105 -layout us -variant colemak

# Janitor
[ -d ~/.local/share/Trash ] && rm -rf ~/.local/share/Trash/*

# Start window manager
exec openbox-session
