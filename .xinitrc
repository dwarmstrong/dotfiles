#!/bin/sh
#
#> Daniel Wayne Armstrong
#> https://github.com/dwarmstrong/dotfiles
#> https://www.dwarmstrong.org
#

userbindkeys=$HOME/.xbindkeysrc
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# config parameters for X client applications
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $userresources ]; then
    xrdb -merge $userresources
fi

# bind commands to certain keys or key combos
if [ -f $userbindkeys ]; then
	xbindkeys
fi

# key mappings
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f $usermodmap ]; then
	sleep 5
    xmodmap $usermodmap
fi

# disable DPMS and turn off screen blanking; note that Xscreensaver and
# xfce4-power-manager use their own DPMS settings and override xset
#xset s off -dpms

# disable system beep
xset b off

# set keyboard layout to colemak
setxkbmap -model pc104 -layout us -variant colemak

# configure trackpoint
if command -v $(xinput list | grep 'TrackPoint' &> /dev/null); then
    xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 1.0
fi

# janitor
if [ -d ~/.local/share/Trash ]; then
	rm -rf ~/.local/share/Trash/*
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# start window manager
exec openbox-session
