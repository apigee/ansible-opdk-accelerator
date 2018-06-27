# Apigee OPDK Setup Ansible Controller Workspace

This folder contains the playbooks that use the [Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) 
role to setup an Ansible Controller. An Ansible controller is used to run Ansible playbooks. The
[setup-control-server.yml](setup-control-server.yml) script enables you to setup an
Ansible controller for setting up a local planet or the structure to manage multiple planets.

This folder also contains the playbook to backup the Ansible Control server using the
[Apigee OPDK Setup Ansible Controller Backup](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller-backup)
role. The [backup-control-server.yml](backup-control-server.yml) script backs up to either a default folder or a provided folder on your local file system.

Please see [Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) or 
[Apigee OPDK Setup Ansible Controller Backup](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller-backup)
for additional details.

# Usage Instructions

## Sample Usage to Setup an Ansible Control Server 

A basic controller setup can be configured in the current directory: 

    # Set the Ansible roles path to the current directory temporarily
    export ANSIBLE_ROLES_PATH=./roles
    
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r setup-control-server-requirements.yml.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup-control-server.yml -e remote_user=<remote user login>

### Change the location of the Ansible working folder
   
    # Set the Ansible roles path to the current directory temporarily
    export ANSIBLE_ROLES_PATH=./roles
    
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r setup-control-server-requirements.yml.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup-control-server.yml -e remote_user=<remote user login> -e ansible_workspace=~/.ansible
    
### Change the location of the Apigee configuration folder
   
    # Set the Ansible roles path to the current directory temporarily
    export ANSIBLE_ROLES_PATH=./roles
    
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r setup-control-server-requirements.yml.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup-control-server.yml -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    
## Sample Usage to Backup an Ansible Control Server 

A backup of a controller setup can be configured in the current directory: 

    # Download the required roles to backup the Ansible controller
    ansible-galaxy install -r backup-control-server-requirements.yml.yml -f
    
    # Backup the Ansible controller
    ansible-playbook backup-control-server.yml 
    
### Sample Usage to Backup to different local folder
   
    # Download the required roles to backup the Ansible controller
    ansible-galaxy install -r backup-control-server-requirements.yml.yml -f
    
    # Backup the Ansible controller
    ansible-playbook backup-control-server.yml -e target_download_folder=<Location on local filesystem>
    

       


