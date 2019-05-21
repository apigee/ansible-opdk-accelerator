# Configure the Ansible OPDK Accelerator 

## Overview

The configuration of the Ansible OPDK Accelerator consists of updating Apigee Security Credentials, an 
[Ansible configuration file](README-configure-ansible.md) and an [Ansible inventory](README-ansible-inventory.md). Please note that this repository 
makes use of a modified layout from most Ansible projects. The layout has been modified to help address concerns with 
security and resource efficiency by making it easy to follow practices that enhance security without sacrificing 
resource efficiency. 

## Ansible OPDK Accelerator Security Strategy

The use of Ansible Vault is encouraged as a mechanism by which you may encrypt sensitive attributes. However it should 
be noted that the use of Ansible Vault is not sufficient without the context of additional conscientious practices that 
complete the security profile of the Ansible configuration. This repository enables conscientious security practices by 
moving sensitive folders and files into the more secure user home directory into hidden folders that are not a part of 
folders placed under source configuration management. This results in processes that make it easy to follow practices 
that enhance security. 

It should be noted that sensitive configuration files should also be properly stored and managed. The practices encouraged
by the layout used in this repository make it easy for sensitive configuration files to be lost. Therefore a conscientious 
effort is required to ensure that sensitive configuration files are properly and securely stored.   

## Ansible OPDK Accelerator Resource Strategy

Ansible configurations can be provided by convention or with settings contained in Ansible configuration files. Ansible 
configurations provided by conventions are convenient for runtime configurations that are short lived or have a reduced 
scope. Ansible configuration files is appropriate when runtime configurations have a larger scope or have a greater 
impact due to the long term maintenance or support concerns that are addressed. This repository provides support for the 
large scope of installation, configuration and maintenance of Apigee Planets. Consequently, this framework configures 
Ansible configuration files so that logs, caches, inventory and roles can be located and shared across the different 
Apigee Planets that may be supported. 

## Configure Ansible OPDK Accelerator Runtime Attributes






have the ability to indicate the location of all resources used by Ansible during a given run.
The configuration of the Ansible runtime is enabled by the use of Ansible configuration files. Ansible Configuration 
can be activated as needed. Ansible configuration files  

1. Copy the Ansible configuration template file named `~/.ansible/multi-planet-configurations/templates/apigee-opdk-configuration-template.cfg` into the folder `~/.ansible/multi-planet-configurations`. 

1. We recommend that you follow the convention of using the name of the target environment as the name of the ansible 
configuration file. For example, to configure a `prod` environment you would name your Ansible configuration file 
`prod.cfg` such that the following step would give you the correct result would be 
`cp ~/.ansible/mult-planet-configurations/templates/apigee-opdk-configuration-template.cfg ~/.ansible/multi-planet-configurations/prod.cfg`.
    
1. Select an inventory template that is close enough to your target environment from the folder `~/.ansible/inventory/templates`. 
You would apply the same convention used to create the Ansible configuration file to the creation of the `inventory` 
folder so that the result would conform to the pattern `~/.ansible/inventory/{{ name_of_configuration_file_without_the_extension }}`. 
For example, suppose that you are creating a 5 node Planet inventory for the `prod.cfg` configuration file you created 
in the prior step then the step that would give you the correct result would be
`cp -r ~/.ansible/inventory/templates/edge-5/ ~/.ansible/inventory/prod/`.

1. Update the Ansible configuration as indicated in [Configure Ansible](README-configure-ansible.md).     
     
1. Update the inventory template files as indicated in [Ansible Inventory](README-ansible-inventory.md).

1. Activate the ansible configuration as indicated in [Activate an Ansible Configuration](README-activate-an-ansible-configuration.md).

## Next Steps

Please continue with the [next steps](README.md#usage-overview) in the process.
