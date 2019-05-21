# Configure Ansible OPDK Accelerator Resources

## Overview

Ansible provides a rich command line syntax by which you can indicate a wide array of configuration attributes. This is 
useful for short sessions that do not need to be persisted over time. The use of the command line syntax over a long 
period of time will quickly become difficult to manage. The use of the command line is managed by using Ansible 
configuration files. The use of Ansible configuration files obviates the need for extended use of the command line so 
that the use of Ansible is managable and intuitive at the command line. It should be noted that the use of Ansible 
configuration files observes the DRY principal to enable the management of multiple inventories from the same set of 
resources. 

## Usage Instructions
Assuming that the instructions in the section [Ansible OPDK Accelerator Configuration](README-ansible-configuration.md) 
[step #1](README-ansible-configuration.md) were followed then you would be able to complete the configuration of 
Ansible with the following steps: 

1. Make a copy of the configuration file template to use as a starter. We recommend that you follow the convention of 
using the name of the target environment as the name of the ansible configuration file. In the example code below we 
assume you will configure a `prod` environment and would name your Ansible configuration file `prod.cfg`. This can be 
accomplished in the following way: 


    cp ~/.ansible/multi-planet-configurations/apigee-opdk-configuration-template.cfg ~/.ansible/multi-planet-configurations/prod.cfg
         
1. Update the new template file for customization. In particular it is necessary for you to indicate the SSH user 
that Ansible will use for server access, the location of the inventory files, the location of the log files, and the 
name of the cache folder. This can be accomplished by updating the Ansible configuration template file with the following
information:

    | Attribute | Description |
    | --- | --- |
    | remote_user | This is the name of the remote SSH user that Ansible will use to connect to target nodes. Replace the template text `UPDATE_WITH_SSH_USER_NAME` with the actual SSH username. |
    | inventory | This is the location of the folder that contains the definition of the Ansible inventory that is served by this configuration file. We recommend using the convention of naming the inventory folder the same name as the target Ansible configuration file without the file extension. Replace the template text `TARGET_ENVIRONMENT_NAME_CONVENTION` with the environment name. |
    | fact_caching_connection | This is the location of the folder that contains the internal Ansible cache. The cache survives playbook invocations and is used to perform calculation necessary to generate configuration files required by Apigee to complete installations or configuration operations. Replace the template text `TARGET_ENVIRONMENT_NAME_CONVENTION` with the environment name. |
    | log_path | This is the location of the Ansible logs and system output to the command line that occurs during the invocation of any playbook or ad-hoc Ansible command. Replace the template text `TARGET_ENVIRONMENT_NAME_CONVENTION` with the environment name. |
    | private_key_file | The SSH private key that Ansible will use for SSH connection. Please validate that this attribute is set to the full path of the correct private SSH key. |

1. Ansible commands will use the Ansible configuration file once it is active. This includes Ansible ad-hoc commands. 
Activate the Ansible configuration as follows: 


    export ANSIBLE_CONFIG=~/.ansible/multi-planet-configurations/prod.cfg
    
1. Select an inventory template that is close enough to your target environment from the folder `~/.ansible/inventory/templates`. 
You would apply the same convention used to create the Ansible configuration file to the creation of the inventory folder 
so that the result would conform to the pattern `~/.ansible/inventory/{{ name_of_configuration_file_without_the_extension }}`. 
For example, suppose that you are creating a 5 node Planet inventory for the `prod.cfg` configuration file you created in 
the prior step then the step that would give you the correct result would be 


    cp -r ~/.ansible/inventory/templates/edge-5/ ~/.ansible/inventory/prod/.

## Next Steps

Please continue with the [next steps](README.md#usage-overview) in the process.
