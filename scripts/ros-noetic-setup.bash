#!/bin/sh

echo "Ready to start ros-noetic setting"
echo "Start setting? (y/n)"
read ans

if [ $ans = 'y' ]; then
    echo "Start ros-noetic-setting"

    echo "set source.list"
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

else
    echo "shutting down"
    exit 1
fi