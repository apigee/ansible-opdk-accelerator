# Adding a Router & Message Processor to a Custom Pod

The playbook `add-rmp-to-custom-pod.yml` will create Apigee Routers and Apigee Message Processors
that are assigned to a Custom Pod. Custom pods are useful because they give you the ability to 
assign a set of specific Message Processors to an organization and environment. 

## Usage Context
The decision to add a Custom Pod signifies that many of our default assumptions will not hold. Consequently in addition 
to the default settings this playbook will prompt you for the information required. Please be prepared to provide the 
following information: 

|  Attribute | Description |
| --- | --- |
| org_name | Organization name |
| env_name | Environment name |
| opdk_mp_pod | Custom pod name |
| virtual_host_port | Create a virtual host for the custom pod |
| virtual_host_name | Create a virtual host name for the custom pod |
| load_balancer | Provide a space delimited list of Router IPs or FQDN of the load balancer that was externally configured for the Virtual Host. The expected list should look like this: `10.142.0.3 10.142.0.4 10.142.0.5` |

### Assumption
* This playbook assumes that the bootstrap components have been installed.

## Usage Use Cases
The playbook can be used as part of an Apigee installation or it can be used to expand an existing installation with 
Routers and Message Processors deployed to Custom Pods. 

## Usage
Assuming you have used this Ansible framework to install the planet then the playbook `add-rmp-to-custom-pod.yml` is used as follows: 

    cd ~/apigee-opdk-accelerator/
    ansible-galaxy install -r post-installation/add/add-components/requirements.yml -f
    ansible-playbook post-installation/add/add-components/add-rmp-to-custom-pod.yml -e target_hosts=rmp[2:3]
    

    
