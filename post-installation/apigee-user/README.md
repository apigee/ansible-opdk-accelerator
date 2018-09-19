# Simplified Apigee User Setup
This script will setup the `apigee` user on the apigee instances.

## Usage: 
This is an Ansible script and require Ansible. Please follow the usage instructions below:

    ansible-galaxy install -r requirements -f
    ansible-playbook update-apigee-user.yml -e target_hosts=<IP address to host>
        