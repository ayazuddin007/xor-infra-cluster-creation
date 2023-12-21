#!bin/bash
a=$(kubectx | grep "cluster/$1")
echo $a
kubectx $1=$a
kubectx $1 
kubectl -n kube-system set env daemonset aws-node WARM_IP_TARGET=3
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.3/cert-manager.yaml
# kubectl apply -f ./modules/eks/cluster_autoscaler.yml

