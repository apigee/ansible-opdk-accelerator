Updating your Inventory File
============================

We use a standard Ansible inventory file with some semantic conventions 
applied to Ansible groups. The semantic model applied to the Ansible 
inventory file is described in the following sections.
 
## Ansible Inventory Files
Ansible provides rich semantics for inventory files. We leverage the 
Ansible model by applying a semantic convention that is based on the 
Apigee Private Cloud domain model for referencing server nodes as 
collections of planets and regions. This means that Apigee semantics are used as group names 
to ascribe roles to normal Ansible inventory files. Please refer to the [Ansible documentation](http://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)
for more information on how this works.  

## Inventory File Conventions
These roles depend on use of conventions in the inventory file. 
Specifically inventory file conventions are [Ansible group](http://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#hosts-and-groups) names that
are defined around Apigee semantics. These Ansible groups are 
semantically linked to the Apigee documentation. The [Ansible groups of groups](http://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html#static-groups-of-dynamic-groups) used as
conventions correspond to the installation roles and server 
categorizations called out in the [Apigee Private Cloud Installation](https://docs.apigee.com/private-cloud/v4.18.01/install-edge-components-node) and 
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

A region represents a subset of a planet. The semantics used for
installation roles are congruent with a region. Regions have been
referenced as data centers. The internal configurations of OPDK and BaaS 
support many regions such as dc-1, dc-2 ... dc-n. Following this
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
    
# Zookeeper Observer Nodes
Zookeeper nodes can be designated as an observer node. Ansible inventory 
files allow variables to be assigned to servers. These roles will update 
the silent installation configuration file correctly for any zookeeper 
node that is assigned the variable zk_observer.
  
     zk_observer=true

## Example Zookeeper Observer Node Configuration
This is a sample of a configuration of a Zookeeper node as an observer. Assuming that the first three nodes listed are
Cassandra/Zookeeper nodes then we can configure a node as a zookeeper observer as follows:

    [planet]
    dc-1-n1
    dc-1-n2
    dc-1-n3 zk_observer=true

    [dc-1-ds]
    dc-1-n[1:3]

# Cassandra Rackaware Configuration
Cassandra nodes can be configured to be rackaware. This leverages the Cassandra built in functionality
for managing itself when the Cassandra ring is distributed across several availability zones. We would
set the variable rack for each member of the Cassandra ring with the designated location we want for
that node in the following way:

    rack=1,1

Please note that this follows the Cassandra rack aware configuration syntax:

    rack=<Availability Zone>,<Position on Rack>

## Example Cassandra Rackaware Configuration
This is a sample of a configuration of Cassandra as a node that is rackaware. Assuming that the first three nodes listed are
Cassandra/Zookeeper nodes then we can configure a node as rackaware as follows:

    [planet]
    dc-1-n1 rack=1,1
    dc-1-n2 rack=2,1
    dc-1-n3 rack=3,1

    [dc-1-ds]
    dc-1-n[1:3]

