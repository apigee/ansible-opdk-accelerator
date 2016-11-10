Updating your inventory file
============================

We use a standard Ansible inventory file with some semantic conventions 
applied to Ansible groups. The semantic model applied to the Ansible 
inventory file is described in the following sections.
 
## Ansible Inventory Files
Ansible provides rich semantics for inventory files. We leverage the 
ansible model by applying a semantic convention that is based on the 
Apigee Private Cloud domain model for referencing server nodes as 
collections of planets and regions. This means that the normal Ansible 
inventory files are used as is with the exception of the semantic 
conventions for inventory group names. 

## Inventory File Conventions
These roles depend on use of conventions in the inventory file. 
Specifically inventory file conventions are ansible groups names that 
are defined around Apigee semantics. These ansible groups are 
semantically linked to the documentation. The ansible groups used as 
conventions correspond to the installation roles and server 
categorizations called out in the Apigee Private Cloud Installation and 
Configuration Guide. It has been useful to use planet and region 
designations combined with the documented installation role names to 
create categorization semantics that should be fairly intuitive once you 
read the Apigee Private Cloud Installation and Configuration Guide. 
   
## Inventory Planet, Region and Installation Role Conventions
A planet refers to all server nodes across all data centers. These 
semantics are held via the use of group names for all nodes that fulfill 
a specific purpose. The installation roles provide the semantic model we 
followed. The inventory file group names for planet level semantics are 
listed in the template inventory file below. 

A region represents subset of a planet. The semantics used for 
installation roles are congruent with a region. Region have been 
referenced as data centers. The internal configurations of OPDK and BaaS 
support many regions as dc-1, dc-2 and so forth. Following this 
historical precedent we also define the regions with their corresponding 
installation role to provide a semantic model as follows:
 
    # Listing that references all data centers that compose a planet. 
    [planet]
    dc-1

    [dc-1]
    # Listing of all nodes in data center 1 (dc-1)
    
    [ds:children]
    # Listing of all the Cassandra and Zookeeper nodes across the planet
    dc-1-ds
    
    [dc-1-ds]
    # Listing of all the Cassandra and Zookeeper nodes in dc-1
    
    [dc-1-ms]
    # Listing of all the Management Server nodes in dc-1
     
    [dc-1-ldap]
    # Listing of all OpenLDAP nodes in dc-1
    
    [dc-1-rmp]
    # Listing of all Router and Message Processor nodes in dc-1
    
    [dc-1-qpid]
    # Listing of all Qpid nodes in dc-1
    
    [dc-1-pg]
    # Listing of all Postgres nodes in dc-1
    
    [dc-1-pgmaster]
    # Listing of the single Postgres master node in dc-1
    
    [dc-1-pgstandby]
    # Listing of the single Postgres standby node in dc-1
    
    [dc-1-ui]
    # Listing of the UI node in dc-1
    
## Zookeeper Observer Nodes
Zookeeper nodes can be designated as an observer node. Ansible inventory 
files allow variables to be assigned to servers. These roles will update 
the silent installation configuration file correctly for any zookeeper 
node that is assigned the variable zk_observer.
  
     zk_observer=true
