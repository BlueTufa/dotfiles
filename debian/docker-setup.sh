#! /bin/bash

# install the docker components
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# TODO: script the conversion to systemd Cgroup
cp daemon.json /etc/docker/
sudo systemctl daemon-reload
sudo systemctl docker restart

