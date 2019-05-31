variable "router_name" {
  default = "default"
}

variable "region" {
  default = "us-east1"
}

variable "zone" {
  default = "us-east1-b"
}

variable "image_name" {
  default = "centos-7"
}

variable "image_project" {
  default = "centos-cloud"
}

variable "machine_type" {
  default = "n1-standard-4"
}

variable "instance_scopes" {
  default = ["compute-rw", "storage-ro"]
}

variable "service_account_email" {
  default = "736255665193-compute@developer.gserviceaccount.com"
}

variable "apigee_ms_ui_port" {
  default = "9000"
}

variable "apigee_ms_api_port" {
  default = "8080"
}

variable "apigee_ms_api_port_name" {
  default = "ui_port_name"
}

variable "apigee_ms_ui_port_name" {
  default = "ui_port_name"
}
