output "member_group" {
  value = openstack_networking_secgroup_v2.postgres_member
}

output "load_balancer_group" {
  value = openstack_networking_secgroup_v2.postgres_load_balancer
}