#!/bin/bash
cd ansible

# Generate dynamic inventory
python3 -c "
import json
with open('inventory/terraform_outputs.json') as f:
    tf = json.load(f)
    with open('inventory/production/hosts.ini', 'w') as inv:
        inv.write('[control_plane]\n')
        inv.write(f"{tf['control_plane_ip']['value']} ansible_user=ec2-user\n\n")
        inv.write('[workers]\n')
        for ip in tf['worker_ips']['value']:
            inv.write(f"{ip} ansible_user=ec2-user\n")
"

# Run playbooks
ansible-playbook -i inventory/hosts.ini playbooks/01-prerequisites.yml
ansible-playbook -i inventory/hosts.ini playbooks/02-create-cluster.yml