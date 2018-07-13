# Apigee OPDK Ansible Configuration Accelerator

## Introduction
This folder contains the playbooks that use the [Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) 
role to setup an Ansible Controller. An Ansible controller is used to run Ansible playbooks. The
[setup.yml](setup.yml) script enables you to setup an Ansible controller to work with either a single
planet for your own testing or to set up to manage multiple planets. The setup required to manage a
single planet or a multiple planet deployment is essentially the same. You require a workspace on the
file system that contain configuration files, roles, cached attributes, log files and your inventory 
of server nodes that will host your planet instance(s).

## Quick Start
The playbook `setup.yml` will setup your folder structure in your user home directory. You can change
the location of you folder structure by updating the `setup.yml` playbook. If you do not provide a 
required attribute then you will be prompted by the script to provide the value. 
 

This folder also contains the playbook to backup the Ansible Control server using the
[Apigee OPDK Setup Ansible Controller Backup](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller-backup)
role. The [backup.yml](backup.yml) script backs up to either a default folder or a provided folder on your local file system.

Please see [Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) or 
[Apigee OPDK Setup Ansible Controller Backup](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller-backup)
for additional details.

# Usage Instructions

## Sample Usage to Setup an Ansible Control Server 

An Ansible controller con be configured to work from any directory. Please edit the setup.yml setup can be configured in the current directory: 

    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r setup-requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e target_host=<IP of target host, can be localhost> -e remote_user=<remote user login>

## Sample Usage to Setup an Ansible Control Server on localhost

A basic controller setup can be configured in the current directory: 

    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r setup-requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -c local -e remote_user=<remote user login>

### Change the location of the Ansible workspace folder
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r setup-requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e remote_user=<remote user login> -e ansible_workspace=~/.ansible
    
### Change the location of the Apigee workspace folder
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r setup-requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    
### Placing the Apigee Secure in a location of your choosing
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r setup-requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e apigee_secure_folder=<User defined path> -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    
### Placing the Apigee Customer Properties in a location of your choosing
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r setup-requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e apigee_custom_properties_folder=<User defined path> -e apigee_secure_folder=<User defined path> -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    
## Sample Usage to Backup an Ansible Control Server 

A backup of a controller setup can be configured in the current directory: 

    # Download the required roles to backup the Ansible controller
    ansible-galaxy install -r backup-requirements.yml-f
    
    # Backup the Ansible controller
    ansible-playbook backup.yml 
    
### Sample Usage to Backup to different local folder
   
    # Download the required roles to backup the Ansible controller
    ansible-galaxy install -r backup-requirements.yml-f
    
    # Backup the Ansible controller
    ansible-playbook backup.yml -e target_download_folder=<Location on local filesystem>
    

       


