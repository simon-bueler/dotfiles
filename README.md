# dotfiles
The folders/files should be linked seperately into ~./.config (`ln -s <repo>/* ~/.config/*`), if there are folders present delete or rename them. Why manual you ask? Because you should know what you are going to do in order to prevent you from breaking your installation. And that way you can decide which settings you intend to use and which not. 

I use Manjaro as a distro and zsh as my shell.

You should setup a `~/.config/sway/config.d/user-config` file in which you should define system/taste specific settings. See mine as an example:

```
# User specific sway configs
#

### Keyboard setting

 input * xkb_layout "ch"

 ### Variables
 #
 # Logo key. Use Mod1 for Alt.
 set $mod Mod4
 # Home row direction keys, like vim
 set $left h
 set $down j
 set $up k
 set $right l
 # Your preferred terminal emulator
 set $term kitty

### Output configuration
#
# Default wallpaper (more resolutions are available in /usr/share/backgrounds/sway/)
 output * bg /home/simon/Pictures/code-2880x1800.jpg fill
#
# Example configuration:
#
#   output HDMI-A-1 resolution 1920x1080 position 1920,0
#
# You can get the names of your outputs by running: swaymsg -t get_outputs

 output eDP-1 resolution 1920x1080 position 0,0
 output DP-5 resolution 2560x1440 position 1920,0

### Input configuration
#
# Example configuration:
#
#   input "2:14:SynPS/2_Synaptics_TouchPad" {
#       dwt enabled
#       tap enabled
#       natural_scroll enabled
#       middle_emulation enabled
#   }
#

 input "1102:4639:DELL081C:00_044E:121F_Touchpad" {
       dwt enabled
       tap enabled
       natural_scroll enabled
     }

 # You can get the names of your inputs by running: swaymsg -t get_inputs
 # Read `man 5 sway-input` for more information about this section.
```

## dependencies
* wofi
* light
* pamixer
* flashfocus
* pavucontrol
* blueberry
* waybar
* mako
* blueberry
* sgtk-menu
* greetd
* greetd-gtkgreet
* ...

### Create user for greetd
```
useradd --system --no-create-home --home-dir /etc/greetd --groups video --shell /usr/bin/nologin
```

