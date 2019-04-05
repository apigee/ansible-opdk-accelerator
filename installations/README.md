# Apigee Edge Installations

The folders in this section perform primary installations of the Apigee platform. These folders all contain the playbook 
`install.yml` that will perform the installation of Apigee Edge component as indicated by the folder name and the 
contained README. This folder contains Ansible playbooks that will install the following Apigee components:

| Component Name | Description | 
|--- | --- |
| [Apigee Edge](multi-node) | Installs a multi-node and multi-region Apigee Edge planet |
| [Apigee Developer Portal](devportal) | Installs Apigee Developer Portal |
| [Apigee Mirror](mirror) | Installs an Apigee Mirror for offline installations |
| [Apigee AIO](aio) |  Installs Apigee Edge as an AIO instance on a single node. |

## Assumptions

1. [Configuration](../../README.md#usage-overview ) steps have been completed. 
1. [Activate an Ansible Configuration](../../README-activate-an-ansible-configuration.md) has been completed.

## Basic Usage
We have created an `ansible-galaxy` requirements file `requirements.yml` that will download and install the roles 
used by this playbook. You can download and install the required roles as follows: 

    ansible-galaxy install -r requirements.yml -f
    
Once the roles are installed you can invoke the install process as follows:

    ansible-playbook install.yml

### Executing Portions of the Installation
It is necessary to many times only execute a portion of the overall installation script. This has been enabled by the 
use of [Ansible tags](http://docs.ansible.com/ansible/latest/cli/ansible-playbook.html#cmdoption-ansible-playbook-tags). 
Ansible tags are used extensively to execute functionally significant portions of the installation. These tags have been 
used consistently across all the installation playbooks. In some cases, the tags perform slightly different tasks but 
achieve the semantic functionality ascribed by the name. Tags are invoked as follows: 

    ansible-playbook install.yml --tags=os
    
### Tags Listing
You can discover the names of tags using the Ansible flag --list-tags as follows: 

    ansible-playbook install.yml --list-tags
    
The following table lists the tag names and a description of the functionality that can be invoked.

| Tag Name | Description |
| --- | --- |
| minimum | Installs without performing any validation on the operating system and minimally verifying that components actually installed. This is the fastest installation available with this framework. |
| cache | Updates the local Ansible cache with OPDK variables that are used for the generation of configuration files. |
| os | Prepares the operating system for the installation of OPDK as covered in the [Edge Installation Overview](https://docs.apigee.com/private-cloud/v4.18.01/installation-overview) and [Install the Edge Apigee Setup Utility](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-apigee-setup-utility). This covers operating system packages, updates to system configuration files and adapts to operating systems. |
| bootstrap | Install the Apigee bootstrap. This adapts to either [online](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-apigee-setup-utility#installedgeapigeesetuputilityonanodewithanexternalinternetconnection) or [offline](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-apigee-setup-utility#installedgeapigeesetuputilityonanodewithnoexternalinternetconnection) |
| common | Install [common](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-apigee-setup-utility) Apigee components used on all nodes. This does not include operating system packages |
| config | Generate the [Edge Configuration File](https://docs.apigee.com/private-cloud/v4.18.01/edge-configuration-file-reference) |
| ds | Install the [ds](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-components-node#specifyingthecomponentstoinstall) profile | 
| ms | Install the [ms](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-components-node#specifyingthecomponentstoinstall) profile | 
| rmp | Install the [rmp](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-components-node#specifyingthecomponentstoinstall) profile | 
| r | Install the [r](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-components-node#specifyingthecomponentstoinstall) profile | 
| mp | Install the [mp](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-components-node#specifyingthecomponentstoinstall) profile | 
| qpid | Install the [qs](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-components-node#specifyingthecomponentstoinstall) profile | 
| pg | Install the [ps](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-components-node#specifyingthecomponentstoinstall) profile |
| org | [Onboard an organization](https://docs.apigee.com/private-cloud/v4.18.01/onboard-organization) |
