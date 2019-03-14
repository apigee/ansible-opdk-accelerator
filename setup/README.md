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
role to configure an Ansible controller to use the framework. The `setup.yml` assumes that the you 
are configuring the localhost. 
* Same setup for either a single planet or multiple planets.
* The user home will be used to create the folders `~/.ansible`, `~/.apigee`, `~/.apigee-secure`, 
and `~/.apigee-workspace`.
* The folder `~/.apigee-workspace` will be used to contain playbooks. Use 
`git clone https://github.com/carlosfrias/apigee-opdk-playbook-installation-single-region.git`to get 
started.
* `ssh` access is working to target servers that will be a part of the Apigee planet.

### Configure SSH Access for your Nodes
A helper playbook is provided for the common task of configuring SSH access to enable the use of 
SSH keys for greater security. Please see 
[Configure SSH Login ](../infrastructure/configure-ssh-login) 
for details. 

### Backup an Ansible Control Server
A helper playbook is provided for the common task of backing up the configurations managed by the 
Ansible control to another file system location. Please see 
[Ansible Control Server Backup](../infrastructure/backup-ansible-controller) for details.

# Usage Instructions

## Download Dependencies
Use `ansible-galaxy` to download dependencies in the following way: 

    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f

## Setup an Ansible Control Server on localhost

`setup.yml` will configure the localhost as an Ansible control server in the following way:
    
    # Setup the Ansible controller
    ansible-playbook setup.yml

## Configuration Review

Templates have been provided to help you configure Ansible and Inventories for use by this framework. 

### Ansible Configuration

Please copy the Ansible configuration template file named apigee-opdk-configuration-template.cfg from 
multi-planet-configurations/templates into the folder multi-planet-configurations. Please name the 
the same as the environment you are configuring. Once you have created a file named for example 
`prod.cfg` please perform the following updates:

1. Search and replace for UPDATE_WITH_SSH_USER_NAME with the name of the SSH user you will use to 
login to each node. 
1. Search and replace for TARGET_ENVIRONMENT_NAME_CONVENTION. Please use the name of the environment 
you are configuring for example `prod`.
1. Export the ANSIBLE_CONFIG environment variable referencing the full path to your updated
Ansible configuration file. 

#### Activate Ansible Configuration

Ansible uses several mechanisms to provide a flexible way to configure a control server. We recommend
using the ANSIBLE_CONFIG environmental variable because it provides you with the flexibility to 
configure many environments as we have indicated here but to a set of scripts. 

    export ANSIBLE_CONFIG=~/.ansible/multi-planet-configurations/prod.cfg
    
1. Ansible commands will now use the ANSIBLE_CONFIG environment variable to find the `prod.cfg` and
the associated inventory folder. 

### Ansible Inventory 

[Ansible Inventory Templates](https://github.com/carlosfrias/apigee-opdk-ansible-inventory-samples) 
have been provided that will assist you to quickly configure your 
inventory. The inventory templates are setup so that you only need to indicate either the FQDN or 
the IP address of a target node. In the `dc-n` area near the top of the template file. The remainder
inventory file uses the Ansible group of groups feature to properly nest your configured nodes in 
their correct roles. 

Please note that we are using the attribute of the Ansible configuration file to point to the a 
folder that can contain inventory files. Ansible will dynamically interpret all files placed in this 
folder as properly defined inventory files. This approach is used to simplify management of nodes 
defined using cloud providers and large inventory definitions.

#### Defining an Inventory to the Ansible Configuration
Assuming an Ansible configuration named `prod.cfg` was defined and that the inventory attribute was 
set as follows `inventory = ~/.ansible/inventory/TARGET_ENVIRONMENT_NAME_CONVENTION` then you can 
define an inventory for a 10 node edge region in `prod` would require the following steps: 

1. Copy the folder `~/.ansible/inventory/templates/edge-10-rmp` to `~/.ansible/inventory/prod`
1. Delete the files `mirror` and `monitoring-dc1`
1. Update each group above the line `# NO MODIFICATIONS BELOW THIS LINE ARE NECESSARY` with the FQDN
or IP address of the node under the group that corresponds to the role of the node. 
