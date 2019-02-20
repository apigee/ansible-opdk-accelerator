Apigee OPDK Cassandra Settings
=========

This role updates the Ansible cache with attributes that are used to generate templates and make 
installation decisions. 

Requirements
------------

This role uses the inventory groups to determine the region of the Cassandra role. A minimum of one
inventory group must be defined for a Cassandra ring. This is accomplished with a `[dc-1-ds]` declared
in the inventory file. The inventory template contains detailed documentation regarding this configuration.

Role Variables
--------------

| Name | Description |
| --- | --- |
| private_address | The attribute `private_address` for each Cassandra node should be available to construct the Cassandra hosts string to be used in a silent response file. |
| region | The attribute `region` for each Cassandra node should be available to construct the Cassandra hosts string to be used in a silent response file. | 


Dependencies
------------

This role has a dependency on the following roles: 

* apigee-opdk-settings-region
* apigee-opdk-settings-private-address


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-settings-cassandra }

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
