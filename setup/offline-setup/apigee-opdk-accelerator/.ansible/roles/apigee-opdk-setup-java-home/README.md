Apigee OPDK Setup Java Home
=========

This role configures the JAVA_HOME variable for use by the Apigee platform. 

Requirements
------------

None

Role Variables
--------------

The `defaults.sh` is updated with the reference to `java_home`. JAVA_HOME and the Apigee platform
PATH is updated to use this instance of Java.


Dependencies
------------

* apigee-opdk-setup-default-settings

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-java-home }

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
