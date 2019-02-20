Apigee Setup Organization
=========================

This role sets up an Apigee organization. 

Requirements
------------

The installation of Apigee OPDK requires root access. Credentials must also be supplied to override the empty placeholders
provided here. It is recommended that credentials be consolidated into a single credentials.yml file that can be stored 
separately. It is assumed that files containing credentials are stored in the ~/.apigee folder. 

Role Variables
--------------

| Variable Name | Description |
| --- | --- |
| admin_user | Administrative user name |
| admin_pass | Administrative user password          |
| user_name | User email address             |
| user_pass | User password                    |
| first_name | User first name          |
| last_name | User last name          |
| org_name | Organization name     |
| virtual_host_port | Virtual host port     |
| virtual_host_name | Virtual host name  |
| virtual_host_alias | Virtual host alias  |
| env_name | Name of environment to create |
| management_server_addr | Host name or ip of the management server      |
| management_server_port | Port numnber of the management server       |
| management_server_host | Full ip address and port to the management server      |
| apigee_installation_path_prefix | Apigee installation directory parent       |
| apigee_installation_home | Apigee installation directory        |
| apigee_bin | Apigee binary directory                        |
| apigee_conf |  Apigee configuration directory        |
| all_status | Apigee all status script             |
| all_start | Apigee all start script            |
| all_stop | Apigee all stop script          |
| create_user | Apigee create user script   |
| create_org | Apigee create organization script    |
| create_roles | Apigee create roles script      |
| add_env | Apigee add environment script      |

The tenants collection can be used to create multiple organizations, environments and users. Structure the tenants collection
as follows: 

    tenants:
    - { org: opdk, env: test, new_user: 'y' }

Dependencies
------------

This role depends on the following roles:

* apigee-opdk-setup-default-settings

Example Playbook
----------------

    ---
    - hosts: '{{ hosts }}'
      become: yes
      
      roles:
      - { role: apigee-opdk-setup-org }
      

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
