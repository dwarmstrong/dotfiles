#!/bin/sh

Xresources=$HOME/.Xresources
Xmodmap=$HOME/.xmodmap
Xbindkey=$HOME/.xbindkeysrc
Xtra=$HOME/.Xtra

if [ -f "$Xresources" ]; then
    xrdb -merge "$Xresources"
fi

if [ -f "$Xmodmap" ]; then
    xmodmap "$Xmodmap"
fi

if [ -f "$Xbindkey" ]; then
    xbindkeys
fi

if [ -f "$Xtra" ]; then
    bash $Xtra
fi

exec i3
