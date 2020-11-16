#! /bin/bash
# https://github.com/coreos/flannel
# IMPORTANT: sudo kubeadm init --pod-network-cidr=10.244.0.0/16
# kubectl taint nodes $(hostname) node-role.kubernetes.io/master:NoSchedule-

kubectl apply -f "https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"

