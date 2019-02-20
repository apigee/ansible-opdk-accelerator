# Apigee OPDK Mirror Archive Installer

This role will install the bootstrap from the Apigee Mirror and that will used to install Apigee in 
an offline environments.

Requirements
------------

The  Apigee Mirror archive has been uploaded to the target hosts and is ready to
be decompressed so that the associated bootstrap can be installed.

Role Variables
--------------

These are the variables that can be updated for this role:

| Name | Description |
| --- | --- |
| opdk_version is The version of OPDK to use. Default: 4.18.05 |
| apigee_archive_name | The name of the archive. Default:  apigee-4.18.05 |
| apigee_archive_file_name | The name of the archive file. Default: apigee-4.18.05.tar.gz |
| apigee_home | Apigee installation home. Default: /opt/apigee |
| apigeerepobasepath | The location from which to download the Apigee Mirror archive. Default: /opt/apigee/data/apigee-mirror |
| local_apigee_path | Local path where the Apigee Mirror archive will be downloaded: Default: ~/.apigee |

Dependencies
------------

Dependencies with the Ansible Galaxy requirements file. Role dependencies are:

* apigee-opdk-default-settings
* apigee-opdk-modules 


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - name: Install apigee mirror archive
      hosts: "{{ target_hosts }}"
      tags: ['install']
      vars:
        ansible_workspace: "~/.ansible"
        apigee_workspace: "~/.apigee-workspace"
        ansible_workspace: "~/.ansible"
        apigee_workspace: "~/.apigee-workspace"
        opdk_version: 4.18.05
        apigeereleasever: 4.18.05
        property_folders:
        - "~/.apigee-secure"
        apigeerepobasepath: '/opt/apigee/data/apigee-mirror'
      roles:
      - { role: apigee-opdk-setup-default-settings, tags: ['cache'] }
      - { role: apigee-opdk-modules }
      - { role: apigee-opdk-setup-os-epel, tags: ['os','epel'] }
      - { role: apigee-opdk-temporary-remove-targets, tags: ['os','remove']}
      - { role: apigee-opdk-shutdown-iptables, tags: ['os','iptables'] }
      - { role: apigee-opdk-yum-repository-proxy-config, tags: ['os','yum-proxy-config']}
      - { role: apigee-opdk-setup-os-minimum, tags: ['os','os-minimum'] }
      - { role: apigee-opdk-setup-os-limits, tags: ['os','limit'] }
      - { role: apigee-opdk-setup-os-sysctl, tags: ['os','sysctl'] }
      - { role: apigee-opdk-setup-selinux-disable, tags: ['os','selinux'] }
      - { role: apigee-server-restart, tags: ['os','restart-server'], start_check_delay: 30, when: (selinux_disabled is defined and selinux_disabled.changed) or (iptables_disabled is defined and not iptables_disabled) or (force_restart is defined and force_restart)  }
      - { role: apigee-opdk-setup-os-common, tags: ['os','os-common'] }
      - { role: apigee-opdk-setup-openjdk, tags: ['os','openjdk'], jdk_version: '1.8' }
      - { role: apigee-opdk-settings-network-ip, tags: ['os','cache']  }
      - { role: apigee-opdk-setup-apigee-user, tags: ['apigee-user', 'bootstrap'] }
      - { role: apigee-opdk-setup-apigee-user-ownership, tags: ['apigee-user', 'bootstrap'] }
      - { role: apigee-opdk-setup-java-home, tags: ['java-home', 'bootstrap'] }
      - { role: apigee-opdk-setup-bootstrap, tags: ['install'], install_archive_mirror: true }
    

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
