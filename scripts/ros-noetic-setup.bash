#!/bin/bash

echo "Ready to start ros-noetic setting"
echo "Start setting? (y/n)"
read ans

if [ $ans = 'y' ]; then
    echo "Start ros-noetic-setting"

    echo "set source.list"
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

    echo "set key"
    sudo apt install curl -y 
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

    echo "update"
    sudo apt update -y 
    echo "Install ROS NOETIC"
    sudo apt install ros-noetic-desktop-full -y 
    if [ $? -gt 0 ]; then
        echo Failed to install ros-noetic
        exit 1
    fi
    
    echo "write ~/.bashrc"
    echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
    source ~/.bashrc

    echo install other dependencies
    sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y
    if [ $? -gt 0 ]; then
        echo Failed to install other dependencies
        exit 1
    fi

    echo "initialize rosdep"
    sudo rosdep init
    rosdep update
    if [ $? -gt 0 ]; then
        echo Failed to init rosdep
        exit 1
    fi

    echo "other necessary package install"
    sudo apt install ibus-mozc -y
    sudo apt-get install python3-testresources ros-noetic-move-base ros-noetic-catkin-virtualenv ros-noetic-slam-gmapping ros-noetic-map-server libpcap-dev -y
    if [ $? -gt 0 ]; then
        echo Failed to install slam-gmapping ...
        exit 1
    fi

    echo "All process finished!!!"

else
    echo "shutting down"
    exit 1
fi
