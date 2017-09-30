#NAME=".bash_profile"
#SOURCE="https://github.com/vonbrownie/dotfiles/blob/master/.bash_profile"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# use qt5ct to configure theme in Qt5 and set environment variable so that
# the settings are picked up by Qt apps.
[[ -x "/usr/bin/qt5ct" ]] && export QT_QPA_PLATFORMTHEME=qt5ct

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
