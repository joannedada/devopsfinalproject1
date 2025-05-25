#!/bin/bash
terraform init
terraform plan
terraform apply -auto-approve
terraform output -json > ../ansible/inventory/terraform_outputs.json