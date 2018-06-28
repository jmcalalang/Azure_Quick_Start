#!/bin/bash

ansible-playbook -v playbooks/application.yml --ask-vault-pass
