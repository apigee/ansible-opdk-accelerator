Apigee OPDK Settings for LDAP
=========

This role updates the Ansible cache with attributes that are used to generate templates and make 
installation decisions. 

This role will add the following attributes to the Ansible cache: 
* opdk_ldap_ip
* opdk_ldap_sid
* opdk_ldap_type
* use_opdk_ldap_remote_host
* opdk_ldap_port
* interface_name

Requirements
------------

This role requires that the inventory group `[dc-1-ms]` be defined. If this role finds the inventory
groups `[dc-1-ms]`, `[dc-1-ldap]`, `[dc-2-ms]`, and `[dc-2-ldap]` then the necessary attributes will 
be set so that replicated LDAP is properly configured between the two regions. 

Role Variables
--------------

| Name | Description |
| --- | --- |
| private_address | The `private_address` attribute should be set prior to using this role |
| [dc-1-ldap] | Inventory group |
| [dc-1-ms] | Inventory group |
| [dc-2-ldap] | Inventory group |
| [dc-2-ms] | Inventory group |
| local_mgmt_ip | This attribute should be set if this is a single region deployment |


Dependencies
------------

* apigee-opdk-setting-private-address
* apigee-opdk-settings-management-server

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-settings-ldap }

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