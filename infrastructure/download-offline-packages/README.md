* Apigee Offline Installation Helper

** Overview

An Apigee offline installation typically requires that you download packages offline. This can be a
long and tedious process. During the creation of the Apigee Mirror you have the option of loading
the missing system packages into the archive. This script has been created to help acquire system 
packages during those times when you discover that you missed them during the creation of the archive.

** Usage

This playbook will make use of the same attributes used by the Apigee Mirror creation scripts so that 
you can immediately get the benefit of downloading missing system packages and leave behind an updated 
list of archives that are required. 

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