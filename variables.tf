variable "member_group_name" {
  description = "Name to give to the security group of postgres members"
  type = string
  default = ""
}

variable "load_balancer_group_name" {
  description = "Name for postgres load balancer security group"
  type        = string
}

variable "client_groups" {
  description = "Id of postgres client security groups"
  type = list(object({
    id = string
    postgres_access = bool
    patroni_access = bool
  }))
  default = []
}

variable "bastion_group_ids" {
  description = "Id of bastion security groups"
  type = list(string)
  default = []
}

variable "metrics_server_group_ids" {
  description = "Id of metric servers security groups"
  type = list(string)
  default = []
}
