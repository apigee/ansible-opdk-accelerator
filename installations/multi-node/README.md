# Install Apigee Edge

The playbook `install.yml` will perform an installation of Apigee Edge. Version 4.16.xx through 4.18.05 can be installed
from this playbook. 

## Basic Usage
We have created `ansible-galaxy` requirement file `requirements.yml` that will download the roles 
used by this playbook and install them for usage according to your configuration. You can download and install the 
required roles like this: 

    ansible-galaxy install -r requirements.yml -f
    
The install process will be engaged when you invoke the playbook like this:

    ansible-playbook install.yml
