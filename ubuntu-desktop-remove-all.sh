#!/usr/bin/env bash

# shellcheck disable=SC2035
sudo apt remove *gnome* *pipewire* *pulseaudio*
sudo apt autoremove
sudo apt autoclean
sudo apt clean
sudo apt update
sudo apt --fix-broken install
sudo apt upgrade
