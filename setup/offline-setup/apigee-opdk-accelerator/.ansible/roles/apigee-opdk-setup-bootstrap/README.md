Apigee OPDK Setup Bootstrap
===========================

This role manages downloading and invoking the bootstrap script from the Apigee servers that will install Apigee 
OPDK service manager.  

Requirements
------------

This role installs the Apigee bootstrap. This role can use your Apigee provided account to login and download required
packages. Additionally, this role also works with a local Apigee repo that is either deployed as a tarball or to an 
Nginx deployment to local data center.
 
Role Variables
--------------
Default values for these variables are provided by the role apigee-opdk-setup-default-settings. The variables used in 
this role are:

| Variable Name | Description |
| --- | --- |
| opdk_resources_path | Temporary staging folder for installation artifacts |
| opdk_user_name | System user name. Set to `apigee` |  
| opdk_group_name | System group name. Set to `apigee` |
| apigee_service | Path to apigee-service command |  
| bootstrap_script | Path to the bootstrap script |
| opdk_version is Version of OPDK to install |
| apigee_repo_url | URL from which to download the bootstrap scripts |
| apigee_repo_user | Apigee repository user name for https://software.apigee.com |
| apigee_repo_password | Apigee repository user password for https://software.apigee.com |
| apigee_repo_host | Apigee repository host that can be used for special releases. |
| apigee_stage | Apigee artifact stage |
| apigee_repo_protocol | Access protocol to the Apigee repo. Set to `file` for a local tarball or `http` for either online or local nginx served repo.
| http_proxy | HTTP Proxy url that should be used to get online |
| https_proxy | HTTPS Proxy url that should be used to get online |
| no_proxy | Domains or IPs that should not be proxied | 
        

Dependencies
------------

* apigee-opdk-setup-default-settings

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-bootstrap }

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