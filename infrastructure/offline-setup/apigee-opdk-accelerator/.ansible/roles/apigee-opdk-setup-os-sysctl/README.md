Apigee OPDK Setup OS Sysctl
=========

This role performs updates to sysctl.conf.

Requirements
------------

None

# ipv6 Tag

Please note that IPV6 is disabled in this role. If you need to by-pass this functionality because IPV6 is already being 
disabled on a system then you can accomplish this by invoking the playbook with the --skip-tags flag like this:

    ansible-playbook install-edge.yml --skip-tags=ipv6 
    
Additional information regarding how Ansible uses tags can be obtained [here](http://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html).     

Role Variables
--------------

The collection `sysctl_ipv6` are the attributes that should be updated in order to disable IPV6 on a node. IPV6 must be 
disabled on all nodes that are part of an Apigee platform instance. 

    sysctl_ipv6:
    - { name: 'net.ipv6.conf.all.disable_ipv6', value: '1' }
    - { name: 'net.ipv6.conf.default.disable_ipv6', value: '1' }

The collection `sysctl_minimum` are the attributes that should be updated on all nodes that are part of an Apigee platform
instance: 

    sysctl_minimum:
    - { name: 'vm.swappiness', value: "{{ vm_swappiness }}" }
    - { name: 'net.ipv6.conf.all.disable_ipv6', value: '1' }
    - { name: 'net.ipv6.conf.default.disable_ipv6', value: '1' }
    - { name: 'net.ipv4.tcp_fin_timeout', value: "{{ apigee_net_ipv4_tcp_fin_timeout }}" }
    - { name: 'vm.max_map_count', value: '{{ apigee_max_map_count }}' }


Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-os-sysctl }

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
