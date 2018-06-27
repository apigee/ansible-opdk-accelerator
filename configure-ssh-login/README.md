# Configure SSH Login

This `configure-ssh-user.yml` playbook configures a user for access over SSH. This playbook can configure
the `root` user so that SSH will permit the `root` user to login. 

# Usage Instructions

## Sample Usage

Configure a user with SSH: 

    # This will invoke the playbook. You will be prompted to type the SSH password for the remote login user provided.
    ansible-playbook configure-ssh-user.yml -u <remote login user> -k -e remote_user=<remote login user> -e hosts=<comma delimited group name, host names or IP addresses>

## Use a specific SSH pubkey

Configure a user with SSH with a non-default ssh public key : 

    # This will invoke the playbook. You will be prompted to type the SSH password for the remote login user provided.
    ansible-playbook configure-ssh-user.yml -u <remote login user> -k -e pubkey=~/.ssh/special-id_rsa.pub -e remote_user=<remote login user> -e hosts=<comma delimited group name, host names or IP addresses>
    
## Enable Root User SSH Login

Configure the root user to enable root user login    

    # This will invoke the playbook. You will be prompted to type the SSH password for the remote login user provided.
    ansible-playbook configure-ssh-user.yml -u <remote login user> -k -e pubkey=~/.ssh/special-id_rsa.pub -e remote_user=root -e hosts=<comma delimited group name, host names or IP addresses>
    