#!/bin/bash

echo "Set up ROS2cs and ros2-for-unity"
echo "Start settings?(y/n)"

read flag_01

if [ $flag_01 = 'n' ]; then
    echo "shutting down"
    exit 1
fi

echo "Download Unity Hub?(y/n)"

read flag_02

if [ $flag_02 = 'y' ]; then
    echo "Get public singing key"
    wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null

    echo "Get repository"
    sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'

    sudo apt update
    echo "Install Unity Hub"
    sudo apt-get install unityhub
