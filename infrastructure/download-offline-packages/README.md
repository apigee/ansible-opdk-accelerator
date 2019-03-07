* Apigee Offline Package Download Helper

** Overview

An Apigee offline installation typically requires that you manually download packages offline. This 
is usually a long and tedious process. During the creation of the Apigee Mirror you have the option 
of loading extra system packages (`archive_extra_packages`) into the repository archive. This 
playbook uses `archive_extra_packages` to immediately download packages from a mirror node to the 
control server running this script and then upload and install those packages on the Planet nodes. 
The use of the same properties as the Apigee Mirror creation playbook provides for a common

** Usage

This playbook will make use of the same attributes used by the Apigee Mirror creation playbook so that 
you can immediately get the benefit of downloading missing system packages by using this playbook 
and leave behind an updated list of archives that are required. 

1. Please update the `archive_extra_packages` attribute in the `~/.apigee/custom-properties.yml` file 
with the list of system packages that you need. An example will look like this: 


    # Extra Yum Packages that should be transferred manually for an offline installation
    archive_extra_packages:
    - yum-utils
    - yum-plugin-priorities
    - libdb4-4.8*
    - boost-filesystem
    
2. Update `local_apigee_path` if you need to store the RPMs in a location other than `~/.apigee`

3. `ansible-playbook.yml offline-download.yml -e target_hosts=<target host where yum packages should be downloaded>`

