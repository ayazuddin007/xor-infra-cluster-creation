#!/bin/bash
name=$(kubectx)
nodegroup=$(aws eks list-nodegroups --cluster-name "$name" | jq -r '.nodegroups[]')

aws eks describe-nodegroup --cluster-name "$name" --nodegroup-name "$nodegroup" | jq -r '.nodegroup.resources.autoScalingGroups | .[].name' &>/dev/null

if [ $? -eq 0 ]; then
    echo SUCCESS for auto-scaling group
    #nodes
    kubectl get nodes | grep -E "ip-.*Ready" &>/dev/null
    if [ $? -eq 0 ]; then
       echo SUCCESS for nodes running in ready state
       #consul namespace pods
       #kubectl get all -n consul | grep -E "pod/*|Running" &>/dev/null
       #if [ $? -eq 0 ]; then
          #echo SUCCESS for consul pods running

          #monitoring namespace pods
          #kubectl get all -n monitoring | grep -E "pod/*|Running" &>/dev/null
          #if [ $? -eq 0 ]; then
             #echo SUCCESS for monitoring  pods running

             #kube-system namespace pods
             kubectl get po -n kube-system | grep -E "ingress-nginx-controller.*Running | aws-load.*Running | aws-cluster-autoscaler.*Running" &>/dev/null
             if [ $? -eq 0 ]; then
                echo SUCCESS for kube-system namespace all pods running
                touch success_cluster.txt
             else
                echo FAIL for kube-system namespace all pods not running
             fi
          #else
            # echo FAIL for pods not running
          #fi

       #else
          #echo FAIL for  consul pods not running
       #fi

    else
       echo FAIL for nodes not running in ready state
    fi
else
    echo FAIL for auto-scaling group
fi
