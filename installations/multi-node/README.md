# Install Apigee Edge

The playbook `install.yml` will perform an installation of Apigee Edge. Version 4.16.xx through 4.18.05 can be installed
from this playbook. Please see the [Setup](https://github.com/apigee/ansible-opdk-accelerator/blob/master/setup/README.md) 
for guidance on configuring your local environment.

## Basic Usage
We have created `ansible-galaxy` requirement file `requirements.yml` that will download the roles 
used by this playbook and install them for usage according to your configuration. You can download and install the 
required roles like this: 

    ansible-galaxy install -r requirements.yml -f
    
The install process will be engaged when you invoke the playbook like this:

    ansible-playbook install.yml



### Ansible Tags
These playbooks use [Ansible tags](http://docs.ansible.com/ansible/latest/cli/ansible-playbook.html#cmdoption-ansible-playbook-tags) 
extensively to execute functionally significant portions of the installation. These tags have been used consistently across all
the playbooks. In some cases, the tags perform slightly different tasks but achieve the semantic functionality ascribed by the name. 

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
| validate | [Validate](https://docs.apigee.com/private-cloud/v4.18.01/test-install) the installation |
| logs | Download the configuration files and logs on a node that contains an Apigee component | 