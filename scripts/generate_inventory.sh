#!/bin/bash

# Create inventory directory if it doesn't exist
mkdir -p ansible/inventory

# Get nodes and format inventory
kubectl get nodes -o json | jq -r '
  .items[] | 
  .metadata.name + " " +
  "ansible_host=" + (.status.addresses[] | select(.type == "ExternalIP" or .type == "InternalIP").address)
' > ansible/inventory/hosts.ini

# Add worker role label to non-control-plane nodes
if [ -s ansible/inventory/hosts.ini ]; then
  sed -i '/control-plane-node=/!s/$/ node-role.kubernetes.io\/worker=/' ansible/inventory/hosts.ini
else
  echo "Warning: No nodes found in inventory"
fi