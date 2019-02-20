# Apigee OPDK Debug Mode

This role will update all of the bash scripts installed for Apigee components so that they 
execute with debug flags set. This causes bash scripts to output large amounts of content 
that is helpful in debugging an issue

Requirements
------------

Assumption that this is running on an node containing Apigee components. 

Role Variables
--------------

| Variable Name | Value | Description |
| --- | --- | --- |
| opdk_debug_mode | 'on' or 'off' | When variable is set then debugging is enabled on all scripts. When the variable is set to 'off' debugging is disabled on all scripts |
| apigee_home | /opt/apigee | The variable containing the Apigee installation home |
| component_name | { name of apigee component } | If provided then only the bashs scripts fo the component will have their debug set to on or off. If not provided then the scripts for all components on the node will be set. |
| bash_regex | #.*bash | The line examined in every script that indicates whether the file is a bash script |  

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

This role can be used in the following ways: 

    - hosts: servers
      roles:
         - { role: apigee-opdk-debug-mode, opdk_debug_mode: 'on' }
         
OR

    - hosts: servers
      vars: 
        opdk_debug_mode: 'on'
      roles:
      - { role: apigee-opdk-debug-mode }

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
