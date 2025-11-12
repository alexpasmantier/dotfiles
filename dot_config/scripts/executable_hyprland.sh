#!/bin/bash

sudo pacman -Syu --noconfirm \
	hyprland cmake kitty waybar hyprpaper \
	brightnessctl playerctl hypridle hyprlock \
	pipewire wireplumber xdg-desktop-portal-hyprland \
	bluetui bottom wiremix


yay -S --noconfirm \
	walker elephant elephant-desktopapplications \
	elephant-files elephant-bluetooth elephant-providerlist \
	elephant-symbols elephant-unicode elephant-websearch \
	elephant-windows elephant-bookmarks \
	clipse hyprshotA wifitui-bin

sudo systemctl --user enable elephant.service
