#!/bin/sh

Xresources=$HOME/.Xresources
Xmodmap=$HOME/.xmodmap
Xbindkey=$HOME/.xbindkeysrc
custom=$HOME/.custom

if [ -f "$Xresources" ]; then
    xrdb -merge "$Xresources"
fi

if [ -f "$Xmodmap" ]; then
    xmodmap "$Xmodmap"
fi

if [ -f "$Xbindkey" ]; then
    xbindkeys
fi

if [ -f "$custom" ]; then
    bash $custom
fi

exec i3
