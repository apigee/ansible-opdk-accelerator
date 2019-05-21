# Configure the Ansible OPDK Accelerator 

## Overview

The configuration of the Ansible OPDK Accelerator consists of updating Apigee Security Credentials, an 
[Ansible configuration file](README-configure-ansible.md) and an [Ansible inventory](README-ansible-inventory.md). Please note that this repository 
makes use of a modified layout from most Ansible projects. The layout has been modified to help address concerns with 
security and resource efficiency by making it easy to follow practices that enhance security without sacrificing 
resource efficiency. 

## Steps to Configure Ansible OPDK Accelerator

1. Update the Ansible configuration as indicated in [Configure Ansible](README-configure-ansible.md).          
1. Update the inventory template files as indicated in [Ansible Inventory](README-ansible-inventory.md).

## Ansible OPDK Accelerator Security Strategy

The use of Ansible Vault is encouraged as a mechanism by which you may encrypt sensitive attributes. However it should 
be noted that the use of Ansible Vault is not sufficient without the context of additional conscientious practices that 
complete the security profile of the Ansible configuration. This repository enables conscientious security practices by 
moving sensitive folders and files into more secure hidden folders of the user home directory that are not a part of 
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

## Next Steps

Please continue with the [next steps](README.md#usage-overview) in the process.
