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

# Alias and Auto Complete
cat <<EOF >>/home/vagrant/.bashrc

# kubectl autocomplete and alias
# https://kubernetes.io/docs/reference/kubectl/cheatsheet/
source <(kubectl completion bash)

alias k=kubectl
complete -o default -F __start_kubectl k

# short alias to set/show context/namespace (only works for bash and bash-compatible shells, current context to be set before using kn to set namespace) 
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'

EOF

# Whoami Deploy for Example
/usr/local/bin/kubectl apply -f /vagrant/whoami.yaml
