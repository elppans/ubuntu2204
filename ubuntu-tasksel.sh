#!/usr/bin/env bash

# tasksel instala o gnome puro

sudo apt update
sudo apt --fix-broken install
sudo apt-get install tasksel -y
sudo tasksel
