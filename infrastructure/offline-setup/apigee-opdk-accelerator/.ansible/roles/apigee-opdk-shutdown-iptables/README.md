Apigee Shutdown IP Tables
==================================

This role shuts down iptables so that Apigee OPDK may be installed. 

Requirements
------------

The installation of Apigee OPDK requires root access. Credentials must also be supplied to override the empty placeholders
provided here. It is recommended that credentials be consolidated into a single credentials.yml file that can be stored 
separately. It is assumed that the credentials are stored in ~/.apigee-secure/credentials.yml. 

Role Variables
--------------

None

Dependencies
------------

* apigee-opdk-setup-default-settings


Example Playbook
----------------

    ---
    - hosts: '{{ target_hosts }}'
      become: yes
      
      roles:
        -  apigee-shutdown-iptables

License
-------

Apache License Version 2.0, January 2004

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
