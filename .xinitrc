#!/bin/sh

Xresources=$HOME/.Xresources
Xmodmap=$HOME/.xmodmap
Xbindkey=$HOME/.xbindkeysrc

if [ -f "$Xresources" ]; then
    xrdb -merge "$Xresources"
fi

if [ -f "$Xmodmap" ]; then
    xmodmap "$Xmodmap"
fi

if [ -f "$Xbindkey" ]; then
    xbindkeys
fi

exec i3
