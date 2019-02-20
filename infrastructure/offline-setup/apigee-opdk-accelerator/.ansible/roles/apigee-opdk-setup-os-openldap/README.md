Apigee OPDK Setup Openldap
=========

This role sets up system packages that enable Openldap to be configured correctly for the Apigee platform. 

Requirements
------------

This role requires elevated system privilege. 

Role Variables
--------------
The `openldap` collection contains the names of the system packages that should be installed assuming it is available and
the version of opdk being installed is greater than 4.17.05: 

    openldap:
    - openldap
    - openldap-clients
    - openldap-servers
    
Should the `openldap` packages fail to install this role will attempt to install the specifically verioned packages listed
in the collection `openldap_downgrade_version`. This logic would apply to installations of OPDK less than 4.17.09. 

    openldap_downgrade_version:
    - openldap-2.4.40
    - openldap-clients-2.4.40
    - openldap-servers-2.4.40

Should the `openldap_downgrade_version` packages fail to install this role will attempt to install the packages from the 
listed urls in the collection `openldap_named_versions`. This failure scenario attempts first to use `yum` and if that 
fails `rpm -ivh --oldpackage`. This logic would apply to installations of OPDK that are less than or equal to 4.17.05 and 
operating system version greater than 6.x. 

    openldap_named_versions:
    - http://mirror.centos.org/centos/6/os/x86_64/Packages/openldap-2.4.40-16.el6.x86_64.rpm
    - http://mirror.centos.org/centos/6/os/x86_64/Packages/openldap-clients-2.4.40-16.el6.x86_64.rpm
    - http://mirror.centos.org/centos/6/os/x86_64/Packages/openldap-servers-2.4.40-16.el6.x86_64.rpm
    - http://mirror.centos.org/centos/6/os/x86_64/Packages/compat-openldap-2.3.43-2.el6.x86_64.rpm

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-os-openldap }

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
