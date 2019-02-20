# Apigee OPDK Mirror Archive Creator

This role will create an Apigee Mirror to be used to install Apigee in an offline environments.

Requirements
------------

The Apigee Bootstrap must be installed so that the Apigee Service component is available prior to 
running this role. 

Role Variables
--------------

These are the variables that can be updated for this role:

| Name | Description |
| --- | --- |
| copy_archive | Copy the Apigee Mirror archive from the control machine or use an existing archive on a target server. Default: `copy_archive: yes` |
| apigee_home | Apigee installation home. Default: /opt/apigee |
| opdk_version is The version of OPDK to use. Default: 4.18.05 |
| apigeereleasever | Apigee release version. Default: opdk_version is
| archive_extra_packages | List of extra packages to include in the archive. Default list: yum-utils, yum-plugin-priorities, libdb4-4.8* |
| no_proxy | no proxy environment variable. Default: '' |
| http_proxy | http proxy environment variable. Default: '' |
| https_proxy | https proxy environment variable. Default: '' |

Dependencies
------------

Dependencies are declared with the Ansible Galaxy requirements file. Role dependencies are:

* apigee-opdk-modules
* apigee-opdk-setup-os-epel
* apigee-opdk-shutdown-iptables
* apigee-opdk-yum-repository-proxy-config
* apigee-opdk-setup-os-minimum
* apigee-opdk-setup-os-sysctl
* apigee-opdk-setup-selinux-disable
* apigee-server-restart
* apigee-opdk-setup-os-common
* apigee-opdk-setup-openjdk
* apigee-opdk-setup-apigee-user
* apigee-opdk-setup-apigee-user-ownership
* apigee-opdk-setup-java-home
* apigee-opdk-setup-bootstrap
* apigee-opdk-setup-apigee-user-ownership


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) 
is always nice for users too:

    - hosts: mirror
      vars: 
        copy_archive: yes
        apigee_home: /opt/apigee
        opdk_version: 4.18.05
        apigeereleasever: 4.18.05
        archive_extra_packages: 
        - yum-utils
        - yum-plugin-priorities
        - libdb4-4.8*
        ansible_workspace: "~/.ansible"
        apigee_workspace: "~/.apigee-workspace"
        property_folders:
        - "~/.apigee-secure"
      roles:
      - { role: apigee-opdk-modules }
      - { role: apigee-opdk-setup-os-epel, tags: ['epel'] }
      - { role: apigee-opdk-shutdown-iptables, tags: ['iptables'] }
      - { role: apigee-opdk-yum-repository-proxy-config, tags: ['yum-proxy-config']}
      - { role: apigee-opdk-setup-os-minimum, tags: ['os-minimum'] }
      - { role: apigee-opdk-setup-os-sysctl, tags: ['sysctl'] }
      - { role: apigee-opdk-setup-selinux-disable, tags: ['selinux'] }
      - { role: apigee-server-restart, tags: ['restart-server'], start_check_delay: 30, when: (selinux_disabled is defined and selinux_disabled.changed) or (iptables_disabled is defined and not iptables_disabled) or (force_restart is defined and force_restart)  }
      - { role: apigee-opdk-setup-os-common, tags: ['os-common'] }
      - { role: apigee-opdk-setup-openjdk, tags: ['openjdk'], jdk_version: '1.8' }
      - { role: apigee-opdk-setup-apigee-user, tags: ['apigee-user', 'bootstrap'] }
      - { role: apigee-opdk-setup-apigee-user-ownership, tags: ['apigee-user', 'bootstrap'] }
      - { role: apigee-opdk-setup-java-home, tags: ['java-home', 'bootstrap'] }
      - { role: apigee-opdk-setup-bootstrap, tags: ['apigee-bootstrap', 'bootstrap'] }
      - { role: apigee-opdk-setup-apigee-user-ownership, tags: ['apigee-user', 'bootstrap'] }
      - { role: apigee-opdk-setup-bootstrap-create-archive, tags: ['create'] }

License
-------

Apache 2.0

Author Information
------------------

Carlos Frias

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
