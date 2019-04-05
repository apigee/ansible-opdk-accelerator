# Activate an Ansible Configuration

Ansible uses several mechanisms to provide a flexible way to configure a control server. We recommend
using the `ANSIBLE_CONFIG` environmental variable because it provides you with the flexibility to 
configure many environments following the steps we have indicated here. 

    export ANSIBLE_CONFIG=~/.ansible/multi-planet-configurations/prod.cfg
    
Ansible commands will now use the `ANSIBLE_CONFIG` environment variable to find the `prod.cfg` and
the associated inventory folder. 

## Maintenance Note

Ansible ad-hoc commands also use the `ANSIBLE_CONFIG` setting. This means that you can perform additional actions
on the Apigee planet beyond what is configured in these playbooks. This allows you the opportunity to carry out 
maintenance activities on multiple servers with a single command. Very cool!

## Next Steps

Please continue with the [next steps](README.md#usage-overview) in the process.
