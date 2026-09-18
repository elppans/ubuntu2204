#!/usr/bin/env bash

sudo apt update
sudo apt --fix-broken install
sudo apt-get install tasksel -y
sudo tasksel
