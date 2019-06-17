# Adding a Router & Message Processor to a Custom Pod

The playbook `add-rmp-to-custom-pod.yml` will create Apigee Routers and Apigee Message Processors
that are assigned to a Custom Pod. Custom pods are useful because they give you the ability to physically isolate traffic
and assign that set of Routers and Message Processors to an organization and environment. 

## Usage Context
The decision to add a Custom Pod signifies that many of our default assumptions will not hold. Therefore in addition 
to the default settings this playbook will also prompt you for the required settings that should be explicitly set for 
custom pod. These settings can be provided as command line parameters if you require integration with your automation 
pipeline.  

### Interactive Mode
If you are running the playbook interactively then please be prepared to provide the 
following information at the command line prompt: 

|  Attribute | Description |
| --- | --- |
| org_name | Organization name |
| env_name | Environment name |
| opdk_mp_pod | Custom pod name |
| virtual_host_port | Create a virtual host for the custom pod |
| virtual_host_name | Create a virtual host name for the custom pod |
| load_balancer | Provide a space delimited list of Router IPs or FQDN of the load balancer that was externally configured for the Virtual Host. The expected list should look like this: `10.142.0.3 10.142.0.4 10.142.0.5` |

### Automation Mode

If you are running this playbook as part of your automation pipeline then please provide the following attributes in the 
command line so that you are not prompted interactively: 

| Attribute | Description |
| --- | --- |
| prompt_org_name | Organization name |
| prompt_env_name | Environment name |
| prompt_opdk_mp_pod | Custom pod name |
| prompt_virtual_host_port | Create a virtual host for the custom pod |
| prompt_virtual_host_name | Create a virtual host name for the custom pod |
| prompt_load_balancer | Provide a space delimited list of Router IPs or FQDN of the load balancer that was externally configured for the Virtual Host. The expected list should look like this: `10.142.0.3 10.142.0.4 10.142.0.5` |

### Assumption
* This playbook assumes that the bootstrap components have been installed.

## Usage Use Cases
The playbook can be used as part of an Apigee installation or it can be used to expand an existing installation with 
Routers and Message Processors deployed to Custom Pods. 

## Interactive Mode Usage
This playbook will be invoked in an interactive mode as follows: 

    cd ~/apigee-opdk-accelerator/
    ansible-galaxy install -r post-installation/add/add-components/requirements.yml -f
    ansible-playbook post-installation/add/add-components/add-rmp-to-custom-pod.yml -e target_hosts=rmp[2:3]

## Automation Mode Usage
This playbook will be invoked in an automation mode as follows: 

    cd ~/apigee-opdk-accelerator/
    ansible-galaxy install -r post-installation/add/add-components/requirements.yml -f
    ansible-playbook post-installation/add/add-components/add-rmp-to-custom-pod.yml -e target_hosts=rmp[2:3] -e prompt_org_name=opdk -e prompt_env_name=noisy_env -e prompt_opdk_mp_pd=noisy_pod -e prompt_virtual_host_port=9001 -e prompt_virtual_host_name=noisy_vh -e prompt_load_balancer='10.142.0.3 10.142.0.4'
    
    OR
    
    ansible-playbook post-installation/add/add-components/add-rmp-to-custom-pod.yml -e target_hosts=rmp[2:3] -e prompt_org_name=opdk -e prompt_env_name=noisy_env -e prompt_opdk_mp_pd=noisy_pod -e prompt_virtual_host_port=9001 -e prompt_virtual_host_name=noisy_vh -e prompt_load_balancer=http://noisy.loadbalancer.org_name.com



