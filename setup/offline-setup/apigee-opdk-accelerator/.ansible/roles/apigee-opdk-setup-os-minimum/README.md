Apigee Setup OS Minimum
=========

This roles setups the minimum operating system packages and configs that would allow OPDK to function properly. This is
a bare bones setup that can be considered a starting point but by no means the full OS setup. 

Requirements
------------

The installation of Apigee OPDK requires root access as does the installation of the system updates that are the focus 
of this role. Credentials must also be supplied to override the empty placeholders provided here. It is recommended that 
credentials be consolidated into a single credentials.yml file that can be stored separately. It is assumed that 
credentials are stored in ~/.apigee-secure/credentials.yml. 

# ipv6 Tag

Please note that IPV6 is disabled in this role. If you need to by-pass this functionality because IPV6 is already being 
disabled on a system then you can accomplish this by invoking the playbook with the --skip-tags flag like this:

    ansible-playbook install-edge.yml --skip-tags=ipv6 
    
Additional information regarding how Ansible uses tags can be obtained [here](http://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html).     

Role Variables
--------------

| Variable Name | Default Value | Description |
| --- | --- | --- |
| apigee_continue_on_warning | y | Defaults for internal environment OPDK setup settings |
| vm_swappiness | 60 | Default value to limit swap file use |
| epel_ol6 | https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm | Default epel repo for EL 6 |
| epel_rhel7 | https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm | Default epel repo for EL 7 |

## Yum System Packages

Yum system packages can be set using the `yum_packages` collection. This can be modified at installation. The default 
packages are listed as: 

    yum_packages:
    - bind-utils
    - chkconfig
    - curl
    - tar
    - wget
    - yum-utils
    - unzip
    - rsync
    - which
    - libselinux-python
    - nss
    - openssh-clients
    - openssh-server
    - grep
    - rpm
    - rng-tools
    - sed

## Sysctl Updates

Sysctl require changes to ensure the smooth operation of Edge. The attributes and values are set using the `sysctl_minimum` 
collection. The default values are listed as: 

    sysctl_minimum:
    - { name: 'vm.swappiness', value: "{{ vm_swappiness }}" }
    - { name: 'net.ipv6.conf.all.disable_ipv6', value: '1' }
    - { name: 'net.ipv6.conf.default.disable_ipv6', value: '1' }
    - { name: 'net.ipv4.tcp_fin_timeout', value: "{{ apigee_net_ipv4_tcp_fin_timeout }}" }
    - { name: 'vm.max_map_count', value: '{{ apigee_max_map_count }}' }
            

Dependencies
------------

This role depends on [apigee-opdk-yum-packages](https://github.com/carlosfrias/apigee-opdk-yum-packages).

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-os-minimum }

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