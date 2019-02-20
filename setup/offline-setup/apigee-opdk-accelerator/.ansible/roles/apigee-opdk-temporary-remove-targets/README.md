Apigee OPDK Temporary Remove Targets
=========

The purpose of this role is to re-locate files temporarily in order to enable an Apigee OPDK Platform installation, 
configuration or maintenance process to complete successfully. This role is complementary to [Apigee OPDK Temporary 
Restore Targets](https://github.com/carlosfrias/apigee-opdk-temporary-restore-targets).

Requirements
------------

It is assumed that this is used manage an Apigee OPDK platform operation. This role works only if the a collection named 
`temporary_move` is defined.


Role Variables
--------------

`temporary_move` must be defined as a collection of objects with the following structure:

    temporary_move:
    - { 
        original_folder: '{ name of folder holding target file }', 
        file_name: '{ name of file to move }', 
        temporary_holding_folder: '{ folder that will temporarily hold artifacts that are expected to be restored }' 
      }

Dependencies
------------

No 

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-temporary-remove-targets }

License
-------

Apache 2.0

Author Information
------------------

Carlos Frias


<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
