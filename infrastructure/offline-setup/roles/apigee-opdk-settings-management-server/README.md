Apigee OPDK Settings for Management Server
=========

This role updates the Ansible cache with attributes that are used to generate templates and make 
installation decisions. 

This role will add the following attributes to the Ansible cache: 
* local_mgmt_ip
* public_mgmt_ip

Requirements
------------

This role requires that the inventory group `[dc-1-ms]` be defined. If this role finds the inventory
groups `[dc-1-ms]` and `[dc-2-ms]` then the necessary attributes will 
be set so that replicated LDAP is properly configured between the two regions. 

Role Variables
--------------

| Name | Description |
| --- | --- |
| private_address | The `private_address` attribute should be set prior to using this role |
| ms_port | Management server port |
| [dc-1-ms] | Inventory group |
| [dc-2-ms] | Inventory group, optional |

Dependencies
------------

* apigee-opdk-setting-private-address

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-settings-management-server }

License
-------

Apache 2.0

Author Information
------------------

Carlos Frias
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
