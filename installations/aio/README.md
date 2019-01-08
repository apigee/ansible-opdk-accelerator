# Install Apigee Edge AIO

The playbook `install.yml` will perform an installation of Apigee Edge AIO. Version 4.16.xx through 4.18.05 can be installed
from this playbook. Please see the [Setup](https://github.com/apigee/ansible-opdk-accelerator/blob/master/setup/README.md) 
for guidance on configuring your local environment.

## Basic Usage
We have created `ansible-galaxy` requirement file `requirements.yml` that will download the roles 
used by this playbook and install them for usage according to your configuration. You can download and install the 
required roles like this: 

    ansible-galaxy install -r requirements.yml -f
    
The install process will be engaged when you invoke the playbook like this:

    ansible-playbook install.yml
