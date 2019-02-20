Apigee OPDK Setup Ansible Controller
=========

This role will setup an Ansible controller with a common directory structure. The structure will
produced at the path indicated by `ansible_workspace` and `apigee_workspace`. Plaase note that
the default path is `~/apigee-workspace` as indicated in the Role Variables below. The following 
structure will be produced: 

    apigee-workspace/
        ├── ansible                               
        │   ├── inventory
        │   │   ├── aio
        │   │   └── templates     
        │   ├── library            
        │   │   ├── cache.py             
        │   │   └── opdk_server_self.py
        │   ├── logs                    
        │   ├── multi-planet-configurations               
        │   │   ├── aio.cfg
        │   │   └── templates                
        │   ├── roles        
        │   └── tmp  
        ├── ansible.cfg
        ├── apigee
        │   └── custom-properties.yml
        │   └── apigee-edge-mirror-4.18.05.tar
        │   └── qpid-proton-c-devel.x86_64.noarch.rpm
        ├── apigee-secure
        │   └── credentials.yml
        │   └── license.txt
        └── playbooks

| Folder | Description | Usage |
| --- | --- | --- |
| apigee | This location has been set aside as storage for information and content that is not sensitive. | You can place `custom-properties.yml` settings that affect an installation here. Addtional items that can be stored here include the tarball for the Apigee Mirror or RPM that need to be manually installed.|
| apigee-secure | This location has been set aside as storage for sensitive information. | Credentials and the license material should be stored here. License material should be stored in a file named `license.txt`. |
| playbooks | This location has been set aside as storage for the Apigee OPDK framework playbooks. | Many playbooks are available but not all are needed. You can download what you need and keep it here. |
| ansible/multi-planet-configurations | This location has been set aside as storage for Ansible configuration files when you need to manage multiple planet configurations. | This is very useful when you need to manage multiple planets such as when a customer environment is composed of individual planets for dev, test, uat, perf, staging and prod. You would match an Ansible configuration file `inventory` path attribute to a single sub-folder of the `inventory` folder. |
| ansible/multi-planet-configurations/aio.cfg | This is an Ansible configuration to configure a planet consisting of a single aio instance. | This Ansible configuration contains the `inventory` attribute set to the folder `inventory/aio`. |
| ansible/multi-planet-configurations/template | This location contains sample configurations file that you can use as templates. |  Select a file and copy it to the configurations folder. Update the attributes as indicated |
| ansible/inventory | This location contains inventory folders that contain Ansible inventory files or scripts | The directory can be used for multi-planet-configurations by setting the Ansible configuration `inventory` attribute to the matching inventory folder here. |
| ansible/inventory/aio | This location is an inventory folders for a planet consisting of a single aio node. | Ansible inventory files included in this folder will be read and resolved in memory by Ansible at runtime. |
| ansible/inventory/templates | This location contains template inventory folders that help you understand how to structure your inventory files. | The inventory templates conform to Apigee's perspective of roles by using Ansible's ability to easily define inventory groups. |
| ansible/library | This location contains Python code modules used throughout the Apigee OPDK setup | Purpose built modules that simplify playbooks. |
| ansible/logs | This location contains logs | The output of Ansible commands are written to the logs. The output in the logs reflect the verbosity level used to run the commands. |
| ansible/roles | This is the location that will contain the Ansible roles used during the execution of the Apigee OPDK framework playbooks. | This folder is populated with roles when you use `ansible-galaxy install` to enable a playbook. |
| ansible/tmp | This is the location that will contain Ansible temporary files and cache entries. | The Ansible cache is used extensively. The cache is found here. The Ansible cache is configured to write attributes in JSON format. This makes it easy to find and modify if needed. |

Requirements
------------

* This role uses properties to generate a basic ansible.cfg; defaults are provided. 
* The `remote_user` variable must be provided.  
* Templates for credentials.yml and customer-properties.yml are provided as a starting point. 
* git and rsync must be installed.

Role Variables
--------------

A description of the variables for this role can be found below: 

| Variable | Description |
| --- | --- |
| remote_user | This variable indicates the remote user that Ansible will be configured to use in the ansible.cfg. There is no default possible for the `remote_user`.  | 
| ansible_workspace | This variable indicates the path where Ansible working files should be installed. The variable defaults to `~/apigee-workspace`. |
| apigee_workspace | This variable indicates the path to the apigee configuration files. The variable defaults to '~/apigee-workspace`. |
| ansible_config | This variable indicates the location of the generated ansible.cfg |
| local_workspace | This variable populates the default value if `ansible_workspace` is not provided |
| setup_dirs | This collection provides the standard list of folders created in the `ansible_workspace` |
| target_apigee_config_folder | This variable populates the default value if the `apigee_config_folder` is not provided. |
| starter_templates | This collections provides the list of template files that will be placed under the `apigee_config_folder` |
| inventory_folder | This variables indicates the location of the inventory folder. |
| library_dir | This variable contains the location of the Ansible library folder. |
| pip_index_url | This variable contains the url to the PIP server that PIP should used. A `pip.conf` file will be generated if this is provided, otherwise no file will be generated |
| pip_config | This variable contains the final name of the pip file and the location. |
| private_key_file | This variable contains the path to the SSH private key Ansible will use to connect |
| repository_secure_endpoint_https | This variable contains the URL to the git https repository endpoint. |
| repository_secure_endpoint_ssh | This variable contains the URL to the git ssh repository endpoint. |
| checkout_type | This is used to select which repository endpoint should be used during a checkout. Possible values are 'https' or 'ssh'. The default value is 'https' |
| template_repos | This collection contains a listing of the github repos to checkout. The structure of each element is: `- { dir: "{{ target_ansible_workspace }}/inventory", repo_name: apigee-opdk-ansible-inventory-samples, dest_name: templates }` |
 

Dependencies
------------

NA

Example Playbook
----------------

This is an example of how to invoke this role: 

    - name: Setup the controller workspace
      hosts: localhost
      connection: local
      gather_facts: no
    
      vars:
        remote_user: friasc
    
      roles:
      - { role: apigee-opdk-setup-ansible }

License
-------

Apache 2.0

Author Information
------------------

Carlos Frias

<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
