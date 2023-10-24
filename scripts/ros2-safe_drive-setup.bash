#!/bin/bash

echo "Ready to start install ros2 humble : safe_drive"
echo "Start settings? (y/n)"

read start_flag

if [ $start_flag = 'y' ]; then
    echo "start settings"

    echo "install dependencies"
    sudo apt install curl gnupg2 lsb-release python3-pip git -y
    if [ $? -gt 0 ]; then
        echo "Failed to install dependencies"
        exit 1
    fi

    echo "install Rust"
    sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    if [ $? -gt 0 ]; then
        echo Failed to install Rust
        exit 1
    fi

    echo "install ROS2 Humble"

    echo "set key"
    sudo curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

    echo "set source.list"
    sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list' 

    echo "set gpg key"
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg 
    sudo apt update > /dev/null

    echo "install ros-humble-desktop"
    sudo apt install ros-humble-desktop python3-colcon-common-extensions -y 
    if [ $? -gt 0 ]; then
        echo Failed to install ROS2
        exit 1
    fi

    . /opt/ros/humble/setup.bash
    echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

    echo "Install Colcon-cargo build system"
    pip install git+https://github.com/tier4/colcon-cargo.git 
    if [ $? -gt 0 ]; then
        echo pip ERROR!!
        exit 1
    fi

    pip install git+https://github.com/colcon/colcon-ros-cargo.git 
    if [ $? -gt 0 ]; then
        echo pip ERROR!!
        exit 1
    fi
    
    echo "install Cargo-ament"
    cd
    git clone https://github.com/tier4/cargo-ament-build.git 
    cd cargo-ament-build
    cargo install --path .
    if [ $? -gt 0 ]; then
        echo Cargo ament error!!
        echo Retry cargo ament install
        exit 1
    fi

    cd
    echo succesfull setting!!
    exit 1
    
else
    echo "shutting down"
    exit 1
fi