# Download Apigee Logs

# Overview
This playbook downloads the logs and configuration settings from an Apigee platform node.

# Requirements

This playbook assumes that an [inventory](../../README-ansible-inventory.md) will be configured using ansible.cfg or on the command line.

# Usage

    ansible-galaxy install -r requirements.yml -f 
    ansible-playbook download-logs.yml -e target_hosts=[ planet | edge | ms | ds | rmp | qpid | pg ]