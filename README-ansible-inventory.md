Updating your Inventory File
============================

We use a standard Ansible inventory file with semantic conventions applied using 
[Ansible groups](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#hosts-and-groups). 
The semantic model applied to the Ansible inventory file is described in the following sections.

# Inventory Templates
[Inventory templates](https://github.com/carlosfrias/apigee-opdk-ansible-inventory-samples) are provided.
 
## Inventory Semantic Model Description
Apigee components must be installed on servers that fulfill a specific role in the topology of Apigee 
Edge Private Cloud. These roles align with the installation profiles described in 
[Install Edge components on a node](https://docs.apigee.com/private-cloud/v4.18.05/install-edge-components-node).
The role of a server is indicated by simply including it in the designated group. Groups can be 
composed as a simple list of servers or as groups of groups. The ability to define groups using the
`:children` syntax enable us the ability to define dynamically scalable topologies that can be hosted
on cloud providers like AWS or GCP. Please refer to the Ansible document
[Working with Inventory](http://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)
for details. We use groups of groups to enable the framework to manage planets of any size. 

## Managing Dynamic Inventory Defintions
Ansible enables you to manage inventory definitions in three ways. First you are able to explicitly 
define nodes and IP addresses directly in a single inventory file. Next, you are able to indicate 
that a file system folder be viewed as containing inventory definitions. This second approach allows
you to decompose a very large inventory into several smaller files that are simplier to manage. 
The final option that Ansible provides to manage inventories is a combination of the second approach
with the inclusion of Ansible provided Ansible scripts. The Ansible provided scripts are executed 
and dynamically construct an inventory that is then available to Ansible playbooks. This last 
approach is used to dynamically discover nodes in AWS and GCP. We will describe using the second 
approach in the remainder of this document.
   
## Inventory Planet, Region and Installation Role Conventions
A planet is composed of regions. A region is a synonym for a data center. Data centers are referred 
by the prefix `dc` and an ordinal. This convention describes a data center as `dc-1`. A second data 
center would be described as `dc-2`. This simple convention is extended for as many data centers as 
required.

## Group Conventions for Managing Apigee Private Cloud
The following provides a detailed technical description of how inventory files are used to define 
the group designation that are used by the Ansible framework to indicate the role of a server. 
Inventory template files are installed using the setup that reduce modifications 
to only indicating server IP addresses. 

### Define an initial data center
We define an initial data center as:

    [dc-1]
    # Listing of all nodes in data center 1 (dc-1)
    # Nodes are listed using inventory file syntax for Ansible
    dc-1-n0 ansible_host=10.x.x.x
    dc-1-n1 ansible_host=10.x.x.x
    dc-1-n2 ansible_host=10.x.x.x
    dc-1-n3 ansible_host=10.x.x.x
    dc-1-n4 ansible_host=10.x.x.x
    dc-1-n5 ansible_host=10.x.x.x
    dc-1-n6 ansible_host=10.x.x.x
    dc-1-n7 ansible_host=10.x.x.x
    dc-1-n8 ansible_host=10.x.x.x
    dc-1-n9 ansible_host=10.x.x.x

### Define a planet
We define a planet as a group of data centers:

    # Listing that references all data centers that compose a planet. 
    [planet:children]
    dc-1
    
### Define Edge group
We define a group of nodes that contain Edge roles as:

    [edge]
    dc-1-n[0:9]

### Define a management server groups
We then define a managment server group in dc-1 as: 
    
    [dc-1-ms]
    dc-1-n0
    
We can add dc-1-ms group to the larger group of all managment servers as: 

    [ms:children]
    dc-1-ms 
    
### Define Cassandra & Zookeeper groups    
We can define a Cassandra & Zookeeper group in dc-1 as:
  
    [dc-1-ds]
    dc-1-n[1:3]
    
We can add the dc-1-ds group to the larger group of all Cassandra & Zookeeper groups as: 

    [ds:children]
    dc-1-ds 
     
### Define Router & Message Processor groups        
We can define Router & Message processor group in dc-1 as: 

    [dc-1-rmp]
    dc-1-n[4:5]
    
We can add the dc-1-rmp group to the larger group of all Routers & Message Processors as: 

    [rmp:children]    
    dc-1-rmp
    
### Define Qpid groups
We can define the Qpid components group in dc-1 as:
    
    [dc-1-qpid]
    dc-1-n[6:7]

We can add the dc-1-qpid group to the larger group of all Qpid components as: 

    [qpid:children]
    dc-1-qpid
    
### Define Postgres groups
We can define the Postgres components group in dc-1 as: 
    
    [dc-1-pg]
    dc-1-n[8:9]
    
We can add the dc-1-pg group to the larger group of all Qpid components as:

    [pg:children]
    dc-1-pg
    
### Define Postgres Master group
This is an optional group that is needed only if a Postgres Master and Postgres Standby will be used. 
We can define a Postgres Master group as:

    [dc-1-pgmaster]
    dc-1-n8
    
### Define Postgres Standby group
This is an optional group that is needed only if a Postgres Master and Postgres Standby will be used. 
We can define a Postgres Standby group as:

    [dc-1-pgstandby]
    dc-1-n9
   
## Zookeeper Observer Nodes
This is an optional attribute if number of Zookeeper nodes is odd. Please consult Apigee documentation
for addtional considerations that apply when deciding to set a Zookeeper observer node. 

Zookeeper nodes can be designated as an observer node. We use the Ansible inventory mechanism to 
indicate which Zookeeper nodes should be designated as observer nodes. This is accomplished as 
follows: 
  
    [dc-1-ds]
    dc-1-n1
    dc-1-n2
    dc-1-n3 zk_observer=true

## Cassandra Rack Aware Configuration
This is an optional attribute. This attribute must configured to indicate to Cassandra that it is 
installed across availability zones. 

Cassandra nodes can be configured to be rack aware. This leverages the Cassandra built in functionality
for managing itself when the Cassandra ring is distributed across several availability zones. We would
set the variable rack for each member of the Cassandra ring with the designated location we want for
that node in the following way:

  
    [dc-1-ds]
    dc-1-n1 rack=1,1
    dc-1-n2 rack=1,1
    dc-1-n3 rack=1,1

# Full Sample Inventory Configuration
[Inventory templates](https://github.com/carlosfrias/apigee-opdk-ansible-inventory-samples) are provided.
   
    [dc-1-edge]
    dc-1-n[0:9]
    
    [dc-1-ds]
    dc-1-n[1:3]
    
    [dc-1-ms]
    dc-1-n0
    
    [dc-1-rmp]
    dc-1-n[4:5]
    
    [dc-1-qpid]
    dc-1-n[6:7]
    
    [dc-1-pgmaster]
    dc-1-n8
    
    [dc-1-pgstandby]
    dc-1-n9
        
    # Groups of groups that don't need to be modified if using PG Master / PG Standby
    [planet:children]
    dc-1
    
    [dc-1:children]
    dc-1-edge
    dc-1-ds
    dc-1-ms
    dc-1-rmp
    dc-1-qpid
    dc-1-pg
    
    [edge:children]
    dc-1-edge
    
    [ms:children]
    dc-1-ms
    
    [ds:children]
    dc-1-ds
    
    [rmp:children]
    dc-1-rmp
    
    [qpid:children]
    dc-1-qpid
    
    [pg:children]
    dc-1-pg
    
    [dc-1-pg:children]
    dc-1-pgmaster
    dc-1-pgstandby
    
    [pgmaster:children]
    dc-1-pgmaster
    
    [pgstandby:children]
    dc-1-pgstandby

## Next Steps

Please continue with the [next steps](README.md#usage-overview) in the process.
