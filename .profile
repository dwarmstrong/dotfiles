# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.
# See /usr/share/doc/bash/examples/startup-files for examples. The files are
# located in the bash-doc package.

# Default umask is set in /etc/profile; for setting the umask for ssh logins,
# install and configure the libpam-umask package.
#umask 022

# If running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$HOME/.local/bin:$PATH"
fi

# Styling QT apps with chosen GTK themes:
# Adwaita themes - install 'adwaita-qt' package, then ...
#export QT_STYLE_OVERRIDE=Adwaita
export QT_STYLE_OVERRIDE=Adwaita-Dark
# Non-adwaita themes - install 'qt5-style-plugins' package, then ...
export QT_QPA_PLATFORMTHEME=gtk2
