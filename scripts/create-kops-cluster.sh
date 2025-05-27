#!/bin/bash

# --- Variables (Modify these!) ---
export NAME="jocluster.k8s.local"  # kOps cluster name
export KOPS_STATE_STORE="s3://jo-kops-state"  # S3 bucket for kOps state
export AWS_REGION="us-east-1"
export VPC_ID="vpc-0b83072163b76b36d"            # Your existing VPC ID
export SUBNET_IDS="subnet-01cea87dd19759ed5,subnet-0ce082831f800c2ed"  # Subnets in the VPC
export ZONES="us-east-1a,us-east-1b"    # Must match subnet AZs
export NODE_COUNT="2"
export NODE_SIZE="t3.medium"
export MASTER_SIZE="t3.medium"

# --- Create Cluster ---
kops create cluster \
  --name=${NAME} \
  --cloud=aws \
  --network-id=${VPC_ID} \
  --subnets=${SUBNET_IDS} \
  --zones=${ZONES} \
  --node-count=${NODE_COUNT} \
  --node-size=${NODE_SIZE} \
  --control-plane-size=${MASTER_SIZE} \
  --yes

# --- Wait for Cluster to be Ready ---
echo "Waiting for cluster to be ready (may take 10-15 mins)..."
kops validate cluster --wait 10m

# --- Configure kubectl ---
kops export kubecfg --admin

# --- Verify Cluster ---
kubectl get nodes
echo "Cluster is ready! 🚀"