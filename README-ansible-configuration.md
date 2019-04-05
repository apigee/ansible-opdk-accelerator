# Ansible OPDK Accelerator Configuration

1. Copy the Ansible configuration template file named `apigee-opdk-configuration-template.cfg` from 
the folder `multi-planet-configurations/templates` into the folder `multi-planet-configurations`. 

1. We recommend that you follow the convention of using the name of the target environment as the name of the ansible 
configuration file. For example, to configure a `prod` environment you would name your Ansible configuration file 
`prod.cfg` such that the following step would give you the correct result would be 
`cp ~/.ansible/mult-planet-configurations/templates/apigee-opdk-configuration-template.cfg ~/.ansible/multi-planet-configurations/prod.cfg`.
    
1. Select an inventory template that is close enough to your target environment from the folder `inventory/templates`. 
You would apply the same convention used to create the Ansible configuration file to the creation of the `inventory` 
folder so that the result would conform to the pattern `inventory/{{ name_of_configuration_file_without_the_extension }}`. 
For example, suppose that you are creating a 5 node Planet inventory for the `prod.cfg` configuration file you created 
in the prior step then the step that would give you the correct result would be
`cp -r ~/.ansible/inventory/templates/edge-5/ ~/.ansible/inventory/prod/`.

1. Update the Ansible configuration as indicated in the section [Editing the Ansible configuration file template](#editing-the-ansible-configuration-file-template).     
     
1. Update the inventory template files as indicated in [Ansible Inventory](README-inventory.md).

1. Activate the ansible configuration as indicated in the section [Activate Ansible Configuration](#activate-ansible-configuration).

## Editing the Ansible configuration file template

Ansible provides a rich command line syntax by which you can indicate a wide array of configuration attributes. This is 
useful for short sessions that do not need to be persisted over time. The use of the command line syntax over a long 
period of time will quickly become difficult to manage for scenarios like installing, configuring and maintaining the Apigee
platform. Consequently, we recommend that you make use of the Ansible configuration file so that the interactions with Ansible at the 
command line would be more concise and consequently easier to manage. If you followed the instructions in the section 
[Ansible OPDK Accelerator Configuration](#ansible-opdk-accelerator-configuration) [step #1](#ansible-opdk-accelerator-configuration) 
then you would be able to complete the configuration of Ansible with the following steps: 

1. Search and replace for `UPDATE_WITH_SSH_USER_NAME` with the name of the SSH user you will use to 
login to each node. The assumption is that you will use the same SSH user to log into each node. 
1. Search and replace for `TARGET_ENVIRONMENT_NAME_CONVENTION` with the name of your target environment. For example, 
if you are configuring a `prod` environment and the Ansible configuration file is named `prod.cfg` and the `inventory` 
created in step #3 is named `inventory/prod` the you would replace the template text `TARGET_ENVIRONMENT_NAME_CONVENTION` 
with `prod`.
1. Activate the Ansible configuration file as indicated in the section [Activate Ansible Configuration](#activate-ansible-configuration).

## Activate Ansible Configuration

Ansible uses several mechanisms to provide a flexible way to configure a control server. We recommend
using the `ANSIBLE_CONFIG` environmental variable because it provides you with the flexibility to 
configure many environments following the steps we have indicated here. 

    export ANSIBLE_CONFIG=~/.ansible/multi-planet-configurations/prod.cfg
    
Ansible commands will now use the `ANSIBLE_CONFIG` environment variable to find the `prod.cfg` and
the associated inventory folder. 

## Maintenance Note

Ansible ad-hoc commands also use the `ANSIBLE_CONFIG` setting. This means that you can perform additional actions
on the Apigee planet beyond what is configured in these playbooks. This allows you the opportunity to carry out 
maintenance activities on multiple servers with a single command. Very cool!
