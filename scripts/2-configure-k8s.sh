#!/bin/bash
cd ansible
ansible-playbook -i inventory/hosts.ini playbooks/01-prerequisites.yml
ansible-playbook -i inventory/hosts.ini playbooks/02-create-cluster.yml