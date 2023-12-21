#!bin/bash
kubens env-dev
kubectl create secret docker-registry xoriant.jfrog.io --docker-server=xoriant.jfrog.io --docker-username=xoriant-jenkins --docker-password=Admin@123