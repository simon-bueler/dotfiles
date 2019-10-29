#!/bin/bash
# First, try to lock screen through logind.
loginctl lock-session
echo "Start"
# logind may fail if this script will be ran from gnome-terminal when GNOME
# session is managed by systemd. Instead, try to use d-bus method provided by
# gnome-shell or gnome-screensaver (the latter is in GNOME Flashback).
if [[ $? != 0 ]]; then
    gdbus call \
       --session \
       --object-path /org/gnome/ScreenSaver \
       --dest org.gnome.ScreenSaver \
       --method org.gnome.ScreenSaver.Lock \
       > /dev/null
    echo "in 1st if"

# If screen was locked by logind, wait a moment. Without this, screen image
# visible before locking may be cached on user TTY which may violate user privacy
# if someone try to switch to that TTY. This is not needed with second method
# because `gdbus` command will wait until work is finished.
else
    sleep 0.4
fi

# Then, try to switch GDM's login screen. If login screen uses Xorg or if greeter
# session was not killed yet (GDM may kill its greeter if Wayland is used,
# for performance) it's needed to switch to login screen's TTY.
loginctl activate \
    $(loginctl list-sessions | grep -m 1 gdm | awk '{print $1}')

# If GDM killed its greeter it's needed to call internal GDM's d-bus method to
# start new greeter session. In this case, GDM will automatically switch to proper
# TTY. This *won't work* if greeter session is already alive.
#if [[ $? != 0 ]]; then
    gdbus call \
        --system \
        --object-path /org/gnome/DisplayManager/LocalDisplayFactory \
        --dest org.gnome.DisplayManager \
        --method org.gnome.DisplayManager.LocalDisplayFactory.CreateTransientDisplay \
        > /dev/null
#fi
sleep 4.0
echo "End"
