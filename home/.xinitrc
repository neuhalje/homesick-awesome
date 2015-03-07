#!/usr/bin/env bash

# Tell OpenOffice that this is Gnome
OOO_FORCE_DESKTOP=gnome

[ -L ~/.config/awesome ] || /bin/ln -s ~/.awesome ~/.config/awesome

/usr/bin/nm-applet &

#Do not do: /usr/bin/gnome-session &
#/usr/bin/unity-settings-daemon --replace &
/usr/bin/gnome-session &

eval $(/usr/bin/gnome-keyring-daemon  --components=pkcs11,secrets,ssh,gpg  --daemonize --replace)
/usr/bin/gnome-terminal &

#exec /usr/bin/awesome
