# Links
# https://computingforgeeks.com/install-gns3-on-kali-linux-rolling/
# https://computingforgeeks.com/install-docker-and-docker-compose-on-kali-linux/

# ======================GNS3 Kali installation======================

# Update System
sudo apt update
sudo apt upgrade

# Dependencies
sudo apt install qemu-block-extra
sudo apt install -y python3-pip python3-pyqt5 python3-pyqt5.qtsvg python3-pyqt5.qtwebsockets qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst wireshark xtightvncviewer apt-transport-https ca-certificates curl gnupg2 software-properties-common

# GNS3
sudo pip3 install gns3-server
sudo pip3 install gns3-gui

# ===============Docker installation===============

# Dependencies
sudo apt install curl gnupg2 apt-transport-https software-properties-common ca-certificates

# Import Docker GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg

# Add Docker repo to Kali Linux
echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" | sudo tee  /etc/apt/sources.list.d/docker.list

# Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

# Add my user to the docker group
sudo usermod -aG docker $USER\nnewgrp docker

# Check if sucessfully installed
docker version
docker run --rm -it  hello-world
# [...]
# Hello from Docker!
# This message shows that your installation appears to be working correctly.
# [...]

# ===============Docker support===============

# GNS3 repository
sudo tee /etc/apt/sources.list.d/gns3.list<<EOF
deb http://ppa.launchpad.net/gns3/ppa/ubuntu bionic main
deb-src http://ppa.launchpad.net/gns3/ppa/ubuntu bionic main
EOF

# Import GPG repository key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F88F6D313016330404F710FC9A2FD067A2E3EF7B

# Update APT package index
sudo apt update

# Install dynamips ubridge
sudo apt install dynamips ubridge

# Add my user the the groups
sudo usermod -aG kvm,libvirt,docker,ubridge,wireshark $USER

# To prevent accidentally installing from that repo
sudo tee /etc/apt/sources.list.d/gns3.list<<EOF
#deb http://ppa.launchpad.net/gns3/ppa/ubuntu bionic main
#deb-src http://ppa.launchpad.net/gns3/ppa/ubuntu bionic main
EOF

# Refresh metadata
sudo apt update

# ===============This is the end===============
gns3
