variable "instance_name" {}
variable "instance_zone" {}

variable "instance_image" {
  default = "centos-7"
}

variable "instance_type" {
  default = "n1-standard-1"
}

variable "instance_network" {}

variable "instance_tags" {
  default = []
}

variable "instance_external_ip" {
  default = ""
}

variable "instance_scopes" {
  default = []
}

variable "service_account_email" {
  default = ""
}

variable "instance_disk_size" {
  default = 100
}

//variable "instance_labels" {
//  default = {
//    g-on-g-notify-ignore = ""
//  }
//}
