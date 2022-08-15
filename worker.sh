#!/bin/bash
arch=$(uname -i)
if [[ $arch == x86_64* ]]; then
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
elif  [[ $arch == arm* ]] || [[ $arch = aarch64 ]]; then
	echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

# install docker engine
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

# install kubernetes
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet=1.21.0-00 kubeadm=1.21.0-00

echo '{"storage-driver": "overlay2", "exec-opts": ["native.cgroupdriver=cgroupfs"]}' | sudo tee  /etc/docker/daemon.json
sudo rm -rf /var/lib/docker/*
sudo systemctl restart docker

sudo apt install -y sysstat

# sudo usermod -aG docker $USER
# newgrp docker
