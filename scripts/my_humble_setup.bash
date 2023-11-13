#!/bin/bash

echo "Start Set ENV??(y/n)"
read flag
if [ $flag = 'n' ]; then
  echo "shutting down"
  exit 1
fi

echo "Start install ROS2 Humble"
echo "Set locale"
locale
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale

echo "Get GPG key"
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update 
sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt upgrade

echo "ROS2-Humble"
sudo apt install ros-humble-desktop

source /opt/ros/humble/setup.bash

echo "Install Rust"
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

echo "install cargo, colcon ..."
pip install git+https://github.com/tier4/colcon-cargo.git
pip install git+https://github.com/colcon/colcon-ros-cargo.git

cd ~/
git clone https://github.com/tier4/cargo-ament-build.git
cd cargo-ament_build
cargo install --path .

echo "Get goole chrome .deb and Install"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

echo "Get Visual-Studio-Code"
curl -s https://raw.githubusercontent.com/karaage0703/ubuntu-setup/master/install-vscode.sh | /bin/bash

sudo apt install ibus-mozc

echo Finished to install my environment
