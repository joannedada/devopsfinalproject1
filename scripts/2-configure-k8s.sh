#!/bin/bash
cd ansible

# Generate group_vars/all.yml from terraform outputs
python3 -c "
import json
with open('inventory/terraform_outputs.json') as f:
    tf = json.load(f)
    with open('group_vars/all.yml', 'w') as vars_file:
        vars_file.write(f\"kops_state_bucket: '{tf['kops_state_bucket']['value']}'\\n\")
        vars_file.write(f\"worker_nodes: {tf['worker_ips']['value']}\\n\")
"

ansible-playbook -i inventory/hosts.ini playbooks/01-prerequisites.yml
ansible-playbook -i inventory/hosts.ini playbooks/02-create-cluster.yml