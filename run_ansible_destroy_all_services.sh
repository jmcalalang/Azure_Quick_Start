#!/bin/bash

ansible-playbook playbooks/destroy_all_services.yml --ask-vault-pass
