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

1. Update the Ansible configuration as indicated in [Configure Ansible](README-configure-ansible.md).     
     
1. Update the inventory template files as indicated in [Ansible Inventory](README-ansible-inventory.md).

1. Activate the ansible configuration as indicated in [Activate an Ansible Configuration](README-activate-an-ansible-configuration.md).
