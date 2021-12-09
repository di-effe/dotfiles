#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xsetroot -cursor_name left_ptr

#export DESKTOP_SESSION=plasma
#exec startplasma-x11
exec dbus-launch leftwm
