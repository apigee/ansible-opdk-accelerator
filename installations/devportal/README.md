# Apigee Private Cloud AIO Installer
This script will install the `aio` profile of the Edge installation. 

## Usage: 
This is an Ansible script and require Ansible. Please follow the usage instructions below:

### Dependencies
Use `ansible-galaxy` to download and install Ansible roles. This is best to perform after [Setup](#setup)
above. 
    
    ansible-galaxy install -r requirements -f
    
### Installer
This playbook completes the installation of the `aio` instances of Edge.

    
    ansible-playbook install.yml 

