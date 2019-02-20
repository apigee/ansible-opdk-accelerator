Apigee OPDK Setup OpenJDK
=========

This roles setups up the OpenJDK system packages. This role also adds Java to the default environment variables for all 
users. This role manages setting up either 1.7 or 1.8. 

Requirements
------------
This role requires elevated system privilege.


Role Variables
--------------

Variables are managed in the apigee-opdk-setup-default-settings role. 

JDK Version to install

    jdk_version: '1.8'
    
Location of JAVA_HOME set in the environment: 

    java_home: /usr/lib/jvm/java-openjdk
    

Dependencies
------------

This role depends on the following roles: 

* apigee-opdk-setup-default-settings 

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-openjdk }

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
