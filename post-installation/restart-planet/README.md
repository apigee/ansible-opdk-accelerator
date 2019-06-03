# Restart an Apigee Planet

It is sometimes necessary to restart an Apigee Planet. This could mean that you only need to restart components so that 
configuration updates can take effect or perhaps the node itself should be restarted. Two playbooks are provided so that
you can make use of what is necessary. 

## Usage
To make use of this playbook it is necessary to ensure you have installed the Ansible roles that are required. Please 
install the Ansible roles using Ansible Galaxy as follows: 

    cd ~/apigee-opdk-accelerator/post-installation/restart-planet
    ansible-galaxy install -r requirements.yml -f
    
## Usage: Restarting Apigee Components
To restart Apigee Components, please ensure that you have installed the Ansible roles as indicated above and then 
follow these steps: 

    cd ~/apigee-opdk-accelerator/post-installation/restart-planet
    ansible-playbook restart-apigee-components.yml
 
## Usage: Restarting Apigee Servers
To restart server nodes that are running Apigee Components we recommend that you first stop Apigee Components and then 
restart the servers. This can be accomplished as indicated below. Please ensure that you have installed the Ansible 
roles as indicated above and then follow these steps: 

    cd ~/apigee-opdk-accelerator/post-installation/restart-planet
    ansible-playbook restart-apigee-servers.yml
 
 