#!/bin/bash

echo "Get goole chrome .deb and Install"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

echo "Get Visual-Studio-Code"
curl -s https://raw.githubusercontent.com/karaage0703/ubuntu-setup/master/install-vscode.sh | /bin/bash
