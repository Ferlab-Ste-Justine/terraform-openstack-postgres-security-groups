# About

This is a terraform module that provisions security groups meant to be restrict network access to a a patroni-managed postgres cluster with load balancers

The following security group is created:
- **member**: Security group for members of the postgres/patroni cluster. It can make external requests and communicate with other members of the **member** group on ports **5432** (postgres port) and **4443** (patroni port)
- **load_balancer**: Security group for the load balancers of the cluster. It can make external requests and communicate with other members of the **member** group on ports **5432** (postgres port) and **4443** (patroni port)

Additionally, you can pass a list of groups that will fulfill each of the following roles:
- **bastion**: Security groups that will have access to the members and load balancers on port **22** as well as icmp traffic.
- **client**: Security groups that will have access to the load balancers on ports **5432** and/or **4443** (depends on access given to them on input) as well as icmp traffic.
- **metrics_server**: Security groups that will have access to the members and load balancers on ports **9200** and **9100** as well as icmp traffic.

# Usage

## Variables

The module takes the following variables as input:

- **member_group_name**: Name to give to the security group for the postgres/patroni members
- **load_balancer_group_name**: Name to give to the security group for the load balancers
- **client_groups**: List of security groups that should have access to the patroni load balancers. Each entry has the following fields:
  - **id**: Id of the client security group
  - **postgres_access**: Boolean indicating whether the client should have access to the postgres port (5432) on the load balancers (suitable for nodes needing application access to the cluster)
  - **patroni_access**: Boolean indicating whether the client should have access to the patroni port (4443) on the load balancers (suitable for nodes needing administrative access to the cluster)
- **bastion_group_ids**: List of ids of security groups that should have **bastion** access to the opensearch cluster
- **metrics_server_group_ids**: List of ids of security groups that should have **metrics server** access to the opensearch cluster.

## Output

The module outputs the following variables as output:

- **member_group**: Security group for the postgres/patroni members that got created. It contains a resource of type **openstack_networking_secgroup_v2**
- **load_balancer_group**: Security group for the load balancers that got created. It contains a resource of type **openstack_networking_secgroup_v2**