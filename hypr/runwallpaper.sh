#! /bin/bash

hyprpm reload

sleep 1

# hacky part
cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.hack

cat ~/.config/hypr/hyprland.conf.hack > ~/.config/hypr/hyprland.conf

rm -f ~/.config/hypr/hyprland.conf.hack 
sleep 1

mpv --wayland-app-id="mpvbg" ~/Downloads/videoplayback.webm --loop
