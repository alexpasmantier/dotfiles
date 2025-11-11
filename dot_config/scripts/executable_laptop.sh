#!/bin/bash

sudo pacman -S tlp tlp-rdw powertop tlpui --noconfirm
sudo systemctl enable tlp.service
sudo systemctl enable NetworkManager-dispatcher.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
