#!/bin/sh
# ~/.xinitrc
#
# Source: https://github.com/vonbrownie/dotfiles/blob/master/.xinitrc

# launch applications at `startx` listed in `~/.config/openbox/autostart

# bind commands to certain keys or key combos
#[ -f ~/.xbindkeysrc ] && xbindkeys     # configured by ~/bin/keyboardconf

# key mappings
#[ -f ~/.xmodmap ] && xmodmap ~/.xmodmap    # keyboardconf

# input devices
#[ -x ~/.xinput.conf ] && ~/.xinput.conf    # keyboardconf

# config parameters for X client applications
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# disable DPMS and turn off screen blanking ... Note that Xscreensaver and
# xfce4-power-manager use their own DPMS settings and override xset config
#xset s off -dpms

# disable system beep
#xset b off

# set keyboard layout to colemak
setxkbmap -model pc105 -layout us -variant colemak

# janitor
[ -d ~/.local/share/Trash ] && rm -rf ~/.local/share/Trash/*

# start window manager
exec openbox-session
