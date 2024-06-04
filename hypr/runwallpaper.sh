#! /bin/bash
hyprpm disable hyprwinwrap
hyprpm enable hyprwinwrap

alacritty -e echo Idatead \& hyprpm reload

# hacky part
cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.hack

cat ~/.config/hypr/hyprland.conf.hack > ~/.config/hypr/hyprland.conf

rm -f ~/.config/hypr/hyprland.conf.hack 

hyprpm reload

mpv --wayland-app-id="mpvbg" ~/Downloads/videoplayback.webm --loop
