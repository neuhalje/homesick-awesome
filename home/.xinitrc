#!/usr/bin/env bash

[ -L ~/.config/awesome ] || /bin/ln -s ~/.awesome ~/.config/awesome

#/usr/bin/nm-applet &

#Do not do: /usr/bin/gnome-session &
/usr/bin/unity-settings-daemon --replace &


eval $(/usr/bin/gnome-keyring-daemon  --components=pkcs11,secrets,ssh,gpg  --daemonize --replace)
/usr/bin/gnome-terminal &

exec /usr/bin/awesome
