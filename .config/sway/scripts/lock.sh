#!/bin/bash

# Lock user session. Use gnome-shell's dbus method instead of `loginctl lock-session`
# to render the animation. Otherwise, screen image visible before locking may be cached
# in user TTY which may violate user privacy if someone try to switch to that TTY.
gdbus call \
       --session \
       --object-path /org/gnome/ScreenSaver \
       --dest org.gnome.ScreenSaver \
       --method org.gnome.ScreenSaver.Lock \
       > /dev/null

greeter_session=$(loginctl list-sessions | grep -m 1 gdm | awk '{print (}')

if [[! -z $greeter_session  ]]; then
   # If login screen uses X11 or greeter session was not killed yet (on Wayland,
   # greeter is killed after some timeout for performance) it's needed to switch
   # to login screen's TTY manually.
   loginctl activate $greeter_session
else
   # If GDM killed its greeter it's needed to call internal GDM's dbus method to
   # start new greeter session. In this case, GDM will automatically switch to
   # proper TTY. This *won't work* if greeter session is already alive.
   gdbus call \
       --system \
       --object-path /org/gnome/DisplayManager/LocalDisplayFactory \
       --dest org.gnome.DisplayManager \
       --method org.gnome.DisplayManager.LocalDisplayFactory.CreateTransientDisplay \
       > /dev/null
fi
sleep 4.0
