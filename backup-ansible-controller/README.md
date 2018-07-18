# Apigee OPDK Ansible Controller Backup
 
This folder also contains the playbook to backup the Ansible Control server using the
[Apigee OPDK Setup Ansible Controller Backup](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller-backup)
role. The [backup.yml](../backup-ansible-controller/backup.yml) script backs up to either a default 
folder or a provided folder on your local file system. Please see  
[Apigee OPDK Setup Ansible Controller Backup](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller-backup)
for details.

# Usage Instructions

A backup of a controller setup can be configured in the current directory: 

    # Download the required roles to backup the Ansible controller
    ansible-galaxy install -r requirements.yml-f
    
    # Backup the Ansible controller
    ansible-playbook backup.yml 
    
## Sample Usage to Backup to different local folder
   
    # Download the required roles to backup the Ansible controller
    ansible-galaxy install -r requirements.yml-f
    
    # Backup the Ansible controller
    ansible-playbook backup.yml -e target_download_folder=<Location on local filesystem>
    

       


