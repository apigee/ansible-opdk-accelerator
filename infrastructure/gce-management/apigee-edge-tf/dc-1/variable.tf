variable "router_name" {
  default = "default"
}

variable "apigeenet_router_name" {
  default = "apigeenet_router"
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
  default = [
    "compute-rw",
    "storage-ro"
  ]
}

variable "dc_region" {
  default = "1"
}

variable "ms_name" { }
variable "ms_count" {
  default = 1
}

variable "ds_name" {}

variable "ds_count" {
  default = 3
}

variable "rmp_name" {}

variable "rmp_count" {
  default = 2
}

variable "qpid_name" {}

variable "qpid_count" {
  default = 2
}

variable "pg_only_name" {}

variable "pg_only_count" {
  default = 1
}

variable "pgmaster_name" {}

variable "pgmaster_count" {
  default = 0
}

variable "pgstandby_name" {}

variable "pgstandby_count" {
  default = 0
}

variable "dev_portal_name" {}

variable "dev_portal_count" {
  default = 0
}

variable "credentials_file" {
//  default = "~/.apigee-secure/sandbox/sandbox-default-service-account.json"
//  default = "~/.apigee-secure/fedex-pilot/fedex-pilot-apigee-service-account.json"
}

variable "gcp_project_name" {
//  default = "sandbox-173316"
//  default = "fedex-pilot"
}

variable "service_account_email" {
//  default = "736255665193-compute@developer.gserviceaccount.com"
//  default = "apigee@fedex-pilot.iam.gserviceaccount.com"
}

variable "nat_dc_2_count" {
  default = "0"
}