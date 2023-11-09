#!/bin/bash

echo "Get goole chrome .deb and Install"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
cd ~/
cd Downloads
sudo apt install ./google-chrome-stable_current_amd64.deb
