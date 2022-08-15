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
sudo apt-get install -y kubectl=1.21.1-00 kubelet=1.21.1-00 kubeadm=1.21.1-00
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
# kubeadm join 172.16.1.18:6443 --token hui4r1.2snrsfx6dddjbaq9 \
#         --discovery-token-ca-cert-hash sha256:83d35f798253081cb7dca502001a3b626dd194b85a9b47660cd924a5918e3473

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
