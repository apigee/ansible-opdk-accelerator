# Setup Apigee OPDK Ansible Configuration Accelerator

## Introduction
An Ansible controller is used to run Ansible playbooks. This repository contains playbooks that 
configure an Ansible controller. The role [Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) 
is used to configure an Ansible Controller and should be consulted for additional details. This 
setup provides you with a common configuration convention that simplifies managing either one planet 
or several planets of any size.  

## Assumptions
* Ansible is installed on the server set aside as an Ansible Controller. 
* The `setup.yml` playbook uses the [Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) 
role to configure an Ansible controller to use the framework. The `setup.yml` assumes that the you are
configuring the localhost. 
* Same setup for either a single planet or multiple planets.
* The user home will be used to create the folders `~/.ansible`, `~/.apigee`, `~/.apigee-secure`, and `~/apigee-workspace`.
* The folder `~/apigee-workspace` will be used to contain playbooks. Use 
`git clone https://github.com/carlosfrias/apigee-opdk-playbook-installation-single-region.git`to get 
started.

### Playbooks
You can `git clone` playbooks to get started and place them in the playbooks folder. You can start 
with this [installation playbook](https://github.com/carlosfrias/apigee-opdk-playbook-installation-single-region).

### Configure SSH Access for your Nodes
If you need to configure SSH access for your nodes but you only have a username and password then take
a look at the [Configure SSH Login ](https://github.com/carlosfrias/apigee-opdk-playbook-setup-ansible/tree/master/configure-ssh-login)
for a playbook to help you set up SSH key access quickly over any number of servers. 

### Backup an Ansible Control Server
If you need to backup the setup of an Ansible control server then take a look at 
[Ansible Control Server Backup](https://github.com/carlosfrias/apigee-opdk-playbook-setup-ansible/tree/master/backup-ansible-controller)
for a playbook to help you backup a control server.

# Usage Instructions

## Sample Usage to Setup an Ansible Control Server 

The `setup.yml` will configure a control server 

    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml 

## Sample Usage to Setup an Ansible Control Server on localhost

A basic controller setup can be configured in the current directory: 

    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -c local -e remote_user=<remote user login>

### Change the location of the Ansible workspace folder
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e remote_user=<remote user login> -e ansible_workspace=~/.ansible
    
### Change the location of the Apigee workspace folder
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    
### Placing the Apigee Secure in a location of your choosing
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e apigee_secure_folder=<User defined path> -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    
### Placing the Apigee Customer Properties in a location of your choosing
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e apigee_custom_properties_folder=<User defined path> -e apigee_secure_folder=<User defined path> -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    