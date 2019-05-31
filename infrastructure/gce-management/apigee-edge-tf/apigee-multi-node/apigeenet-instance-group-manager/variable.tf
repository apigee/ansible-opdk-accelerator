variable "instance_name" {}

variable "group_manager_name" {}

variable "instance_network" {}

variable "instance_size" {
  default = 60
}

variable "instance_count" {
  default = 1
}

variable "instance_region" {
  default = "us-east1"
}

variable "instance_distribution_policy_zones" {
  default = ["us-east1-d"]
}

variable "group_manager_port" {}
variable "group_manager_port_name" {}

variable "instance_tags" {
  default = []
}

variable "machine_type" {
  default = "n1-standard-1"
}

//variable "ip_address" {}

