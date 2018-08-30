# Setup Apigee OPDK Ansible Configuration Accelerator

## Introduction
An Ansible controller is used to run Ansible playbooks. This repository contains playbooks that setup 
an Ansible controller. The role [Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) 
is used to setup an Ansible Controller. 

## Assumptions
The `setup.yml` playbook uses [Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) 
to configure an Ansible controller to use the framework. The `setup.yml` assumes that the you are
configuring the localhost. 
 
 to automate working with either a single planet or automate multiple 
planets for the management of an Enterpreise scale development environment. This setup provides you 
with a common configuration convention that simplifies managing either either one planet or several 
of any size.  

## Quick Start
The playbook `setup.yml` will setup your folder structure in your user home directory. You can change
the location of you folder structure by providing updated folder paths using the `setup.yml` playbook. 
If you do not provide a required attribute then you will be prompted by the script to provide the 
value. Please see 
[Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) 
for additional details.

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
    