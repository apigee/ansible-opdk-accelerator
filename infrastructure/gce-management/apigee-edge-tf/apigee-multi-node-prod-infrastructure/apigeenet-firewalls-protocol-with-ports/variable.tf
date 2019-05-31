variable "firewall_name" {}
variable "firewall_network" {}

variable "firewall_source_ranges" {
  type = "list"
}

variable "firewall_protocol" {}

variable "firewall_ports" {
  default = []
}

variable "firewall_source_tags" {
  type = "list"
}

