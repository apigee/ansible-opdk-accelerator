# Enable Debug Mode for Apigee Edge Scripts

The playbook `debug.yml` will set the debug flag on all of the Edge component scripts. 
 
## Basic Usage 
    
To set debug mode you invoke the playbook like this: 

    ansible-playbook debug.yml -e opdk_debug_mode='on'
    
To unset debug mode you invoke the playbook like this:

    ansible-playbook debug.yml -e opdk_debug_mode='off'
    
To set debug mode on the scripts for an Edge component then use the `-e component_name` variable like this:
 
    ansible-playbook debug.yml -e opdk_debug_mode='on' -e component_name='message-processor'
    
## Dependencies

This playbook assumes that you followed the instructions for setting up [Ansible](https://github.com/carlosfrias/apigee-opdk-playbook-setup-ansible).    
Please refer to the documentation for [apigee-opdk-debug-mode](https://github.com/carlosfrias/apigee-opdk-debug-mode). 

We have created `ansible-galaxy` requirement file `requirements.yml` that will download the roles 
used by this playbook and install them for usage according to your configuration. You can download and install the 
required roles like this: 

    ansible-galaxy install -r requirements.yml -f

