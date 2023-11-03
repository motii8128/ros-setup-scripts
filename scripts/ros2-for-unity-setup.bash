#!/bin/bash

echo "Download UnityHub and set up ROS2cs and ros2-for-unity"
echo "15~30 minutes"
echo "Start settings?(y/n)"

read flag_01

if [ $flag_01 = 'n' ]; then
    echo "shutting down"
    exit 1
fi

# download unity hub
echo "Get public singing key"
wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null

echo "Get repository"
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'

sudo apt update
echo "Install Unity Hub"
sudo apt-get install unityhub
if [ $? -gt 0 ]; then
    echo Failed to install unityhub
    exit 1
fi

# build ros2 C#
echo "BUILD ROS2cs"

echo "Install rmw and test msg"
sudo apt install -y ros-humble-test-msgs
sudo apt install -y ros-humble-fastrtps ros-humble-rmw-fastrtps-cpp
sudo apt install -y ros-humble-cyclonedds ros-humble-rmw-cyclonedds-cpp
if [ $? -gt 0 ]; then
    echo Failed to install rmw and test msg
    exit 1
fi

echo "Install vcs tool"
curl -s https://packagecloud.io/install/repositories/dirk-thomas/vcstool/script.deb.sh | sudo bash
sudo apt-get update
sudo apt-get install -y python3-vcstool
if [ $? -gt 0 ]; then
    echo Failed to install vcs tool
    exit 1
fi

echo "Install .NET core 6.0 SDK"
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0
if [ $? -gt 0 ]; then
    echo Failed to install .NET
    exit 1
fi

echo "start ros2cs build"
cd ~/
git clone https://github.com/RobotecAI/ros2cs.git
if [ $? -gt 0 ]; then
    echo Failed to git clone ros2cs
    exit 1
fi
source /opt/ros/humble/setup.bash

cd ros2cs
echo "Get repo"
./get_repos.sh
if [ $? -gt 0 ]; then
    echo Failed to get repo
    exit 1
fi

echo "BUILD start"
./build.sh
if [ $? -gt 0 ]; then
    echo Failed to Build ros2cs
    exit 1
fi

echo "Get ros2-for-unity"