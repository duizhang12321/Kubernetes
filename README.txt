按顺序完成以下步骤，参考官方安装教程：https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

On master node: 
./master.sh
保存输出的kubeadm join指令

On worker nodes: 
./worker.sh
执行刚才保存的kubeadm join指令

On master node:
./network.sh

On master node:
kubectl get node -o wide
检查所有node是否处于Ready状态

