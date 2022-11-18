#!/bin/bash

# Update
yum update -y

# DNS
file="/etc/hosts"
( 
    echo "192.168.0.50    k3s-master.lab"
    echo "192.168.0.51    k3s-node01.lab"
    echo "192.168.0.52    k3s-node02.lab"
) >> $file

# K3S Install
curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET sh -s - server --cluster-init --write-kubeconfig-mode 644 --node-external-ip "192.168.0.50"
