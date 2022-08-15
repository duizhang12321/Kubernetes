#!/bin/bash

# kubectl taint nodes $HOSTNAME node-role.kubernetes.io/master-
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml