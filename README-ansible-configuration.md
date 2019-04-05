# Ansible OPDK Accelerator Configuration

1. Copy the Ansible configuration template file named `apigee-opdk-configuration-template.cfg` from 
the folder `multi-planet-configurations/templates` into the folder `multi-planet-configurations`. 
1. We recommend that you follow the convention of name the template file you copied the same as the name of the 
environment you are configuring.
1. Update the template file as indicated below.
1. Select an inventory template that is close enough to your target environment from the folder `inventory/templates` 
and copy that folder to `inventory/{{ name_of_configuration_file_without_the_extension }}`.
1. Update the `inventory/{{ name_of_configuration_file_without_the_extension }}` files as indicated with 
[Ansible Inventory Templates](https://github.com/carlosfrias/apigee-opdk-ansible-inventory-samples).

Once you have created a file named for example 
`prod.cfg` please perform the following updates:

1. Search and replace for UPDATE_WITH_SSH_USER_NAME with the name of the SSH user you will use to 
login to each node. 
1. Search and replace for TARGET_ENVIRONMENT_NAME_CONVENTION. Please use the name of the environment 
you are configuring for example `prod`.
1. Export the ANSIBLE_CONFIG environment variable referencing the full path to your updated
Ansible configuration file. 

## Activate Ansible Configuration

Ansible uses several mechanisms to provide a flexible way to configure a control server. We recommend
using the ANSIBLE_CONFIG environmental variable because it provides you with the flexibility to 
configure many environments as we have indicated here but to a set of scripts. 

    export ANSIBLE_CONFIG=~/.ansible/multi-planet-configurations/prod.cfg
    
1. Ansible commands will now use the ANSIBLE_CONFIG environment variable to find the `prod.cfg` and
the associated inventory folder. 

## Ansible Inventory 

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

## Defining an Inventory to the Ansible Configuration
Assuming an Ansible configuration named `prod.cfg` was defined and that the inventory attribute was 
set as follows `inventory = ~/.ansible/inventory/TARGET_ENVIRONMENT_NAME_CONVENTION` then you can 
define an inventory for a 10 node edge region in `prod` would require the following steps: 

1. Copy the folder `~/.ansible/inventory/templates/edge-10-rmp` to `~/.ansible/inventory/prod`
1. Delete the files `mirror` and `monitoring-dc1`
1. Update each group above the line `# NO MODIFICATIONS BELOW THIS LINE ARE NECESSARY` with the FQDN
or IP address of the node under the group that corresponds to the role of the node. 
