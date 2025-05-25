#!/bin/bash
cd ansible

# Get kOps nodes
kubectl get nodes -o json | jq -r '.items[] | .metadata.name + " ansible_host=" + .status.addresses[] | select(.type=="ExternalIP").address' > inventory/hosts.ini

# Add control plane label
sed -i '/control-plane-node=/!s/$/ node-role.kubernetes.io\/worker=/' inventory/hosts.ini