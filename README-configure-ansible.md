# Configure Ansible

Ansible provides a rich command line syntax by which you can indicate a wide array of configuration attributes. This is 
useful for short sessions that do not need to be persisted over time. The use of the command line syntax over a long 
period of time will quickly become difficult to manage for scenarios like installing, configuring and maintaining the Apigee
platform. Consequently, we recommend that you make use of the Ansible configuration file so that the interactions with Ansible at the 
command line would be more concise and consequently easier to manage. If you followed the instructions in the section 
[Ansible OPDK Accelerator Configuration](README-ansible-configuration.md) [step #1](README-ansible-configuration.md) 
then you would be able to complete the configuration of Ansible with the following steps: 

1. Search and replace for `UPDATE_WITH_SSH_USER_NAME` with the name of the SSH user you will use to 
login to each node. The assumption is that you will use the same SSH user to log into each node. 
1. Search and replace for `TARGET_ENVIRONMENT_NAME_CONVENTION` with the name of your target environment. For example, 
if you are configuring a `prod` environment and the Ansible configuration file is named `prod.cfg` and the `inventory` 
created in step #3 is named `inventory/prod` the you would replace the template text `TARGET_ENVIRONMENT_NAME_CONVENTION` 
with `prod`.
1. Activate the Ansible configuration file as indicated in the section [Activate an Ansible Configuration](README-activate-an-ansible-configuration.md).

## Next Steps

Please continue with the [next steps](README.md#usage-overview) in the process.
