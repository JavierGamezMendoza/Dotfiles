#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Composer
picom &
# Network
nm-applet &
# Keyboard Layout
setxkbmap es &
# Automount Devices
udiskie -t &
# Java Fonts
xsettingsd &
# Wallpaper
feh --bg-scale /home/habi/Downloads/wallpaper.png &
# Audio
#pulseaudio &
# Pantallas
xrandr --output HDMI-2 --mode 1360x768 --pos 1440x194 --rotate normal --output DVI-D-1 --off --output VGA-2 --off --output VGA-1-1 --primary --mode 1440x900 --pos 0x0 --rotate normal --output HDMI-1-1 --off --output DP-1-1 --off &