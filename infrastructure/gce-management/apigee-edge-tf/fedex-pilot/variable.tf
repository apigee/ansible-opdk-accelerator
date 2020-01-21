variable "router_name" {
  default = "default"
}

variable "apigeenet_router_name" {
  default = "apigeenet_router"
}

variable "dc_1_gcp_region" {
  default = "us-east1"
}

variable "dc_2_gcp_region" {
  default = ""
}

variable "dc_3_gcp_region" {
  default = ""
}

variable "dc_1_zone" {
  default = "us-east1-b"
}

variable "dc_2_zone" {
  default = ""
}

variable "dc_3_zone" {
  default = ""
}

variable "image_name" {
  default = "centos-7"
}

variable "image_project" {
  default = "centos-cloud"
}

variable "machine_type" {
  default = "n1-standard-8"
}

variable "instance_scopes" {
  default = [
    "compute-rw",
    "storage-ro"
  ]
}

variable "dc_1_region" {
  default = "1"
}

variable "dc_2_region" {
  default = "2"
}

variable "dc_3_region" {
  default = "3"
}

variable "dc_1_ms_name" { }

variable "dc_2_ms_name" { }

variable "dc_1_ms_count" {
  default = 1
}

variable "dc_2_ms_count" {
  default = 1
}

variable "dc_1_ds_name" {}

variable "dc_2_ds_name" {}

variable "dc_3_ds_name" {}

variable "dc_1_ds_count" {
  default = 3
}

variable "dc_2_ds_count" {
  default = 0
}

variable "dc_3_ds_count" {
  default = 0
}

variable "dc_1_rmp_name" {}

variable "dc_2_rmp_name" {}

variable "dc_3_rmp_name" {}

variable "dc_1_rmp_count" {
  default = 2
}

variable "dc_2_rmp_count" {
  default = 0
}

variable "dc_3_rmp_count" {
  default = 0
}

variable "dc_1_qpid_name" {}

variable "dc_2_qpid_name" {}

variable "dc_3_qpid_name" {}

variable "dc_1_qpid_count" {
  default = 2
}

variable "dc_2_qpid_count" {
  default = 0
}

variable "dc_3_qpid_count" {
  default = 0
}

variable "pg_only_name" {}

variable "pg_only_count" {
  default = 1
}

variable "dc_1_pgmaster_name" {}

variable "dc_2_pgmaster_name" {}

variable "dc_1_pgmaster_count" {
  default = 0
}

variable "dc_2_pgmaster_count" {
  default = 0
}

variable "dc_1_pgstandby_name" {}

variable "dc_2_pgstandby_name" {}

variable "dc_1_pgstandby_count" {
  default = 0
}

variable "dc_2_pgstandby_count" {
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