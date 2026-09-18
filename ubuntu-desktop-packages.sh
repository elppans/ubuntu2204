#!/usr/bin/env bash

pacotes=(
branding-ubuntu
fonts-ubuntu
gnome-shell-extension-ubuntu-dock
gsettings-ubuntu-schemas
network-manager-config-connectivity-ubuntu
plymouth-theme-ubuntu-text
ubuntu-advantage-desktop-daemon
ubuntu-advantage-tools
# ubuntu-desktop
ubuntu-desktop-minimal
ubuntu-docs
ubuntu-drivers-common
ubuntu-keyring
ubuntu-minimal
ubuntu-mono
ubuntu-pro-client
ubuntu-pro-client-l10n
ubuntu-release-upgrader-core
ubuntu-release-upgrader-gtk
ubuntu-report
ubuntu-restricted-addons
ubuntu-session
ubuntu-settings
ubuntu-standard
ubuntu-wallpapers
ubuntu-wallpapers-jammy
gstreamer1.0-pipewire:amd64
libpipewire-0.3-0:amd64
libpipewire-0.3-common
libpipewire-0.3-modules:amd64
pipewire:amd64
pipewire-bin
pipewire-media-session
gstreamer1.0-pulseaudio:amd64
pulseaudio
pulseaudio-module-bluetooth
pulseaudio-utils
alsa-base
alsa-topology-conf
alsa-ucm-conf
alsa-utils
gstreamer1.0-alsa:amd64
)

sudo apt update
sudo apt --fix-broken install
sudo apt install --reinstall "${pacotes[@]}"
sudo apt upgrade -y
sudo apt clean
sudo apt autoclean
sudo apt autoremove

sleep 15
sudo systemctl reboot -i