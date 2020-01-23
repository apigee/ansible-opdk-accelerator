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

variable "dc_1_ms_name" { }

variable "dc_1_ms_count" {
  default = 1
}

variable "dc_1_ms_disk_size" {
  default = 100
}

variable "dc_1_ms_instance_type" {}

variable "dc_1_ds_name" {}

variable "dc_1_ds_count" {
  default = 3
}

variable "dc_1_ds_instance_type" {}

variable "dc_1_ds_disk_size" {
  default = 250
}

variable "dc_1_rmp_name" {}

variable "dc_1_rmp_count" {
  default = 2
}

variable "dc_1_rmp_instance_type" {}

variable "dc_1_rmp_disk_size" {
  default = 100
}

variable "dc_1_qpid_name" {}

variable "dc_1_qpid_count" {
  default = 2
}

variable "dc_1_qpid_instance_type" {}

variable "dc_1_qpid_disk_size" {
  default = 500
}

variable "dc_1_pgmaster_name" {}

variable "dc_1_pgmaster_count" {
  default = 0
}

variable "dc_1_pgmaster_instance_type" {}

variable "dc_1_pgmaster_disk_size" {
  default = 4000
}

variable "dc_1_pgstandby_name" {}

variable "dc_1_pgstandby_count" {
  default = 0
}

variable "dc_1_pgstandby_instance_type" {
  default = 4000
}

variable "dc_1_pgstandby_disk_size" {}

variable "dc_2_region" {
  default = "2"
}

variable "dc_2_ms_name" { }

variable "dc_2_ms_instance_type" {}

variable "dc_2_ms_count" {
  default = 1
}

variable "dc_2_ms_disk_size" {
  default = 100
}
variable "dc_2_ds_name" {}

variable "dc_2_ds_instance_type" {}

variable "dc_2_ds_count" {
  default = 0
}

variable "dc_2_ds_disk_size" {
  default = 250
}

variable "dc_2_rmp_name" {}

variable "dc_2_rmp_count" {
  default = 0
}

variable "dc_2_rmp_instance_type" {}

variable "dc_2_rmp_disk_size" {
  default = 100
}

variable "dc_2_qpid_name" {}

variable "dc_2_qpid_count" {
  default = 0
}

variable "dc_2_qpid_instance_type" {}

variable "dc_2_qpid_disk_size" {
  default = 500
}

variable "dc_2_pgmaster_name" {}

variable "dc_2_pgmaster_count" {
  default = 0
}

variable "dc_2_pgmaster_instance_type" {}

variable "dc_2_pgmaster_disk_size" {
  default = 4000
}

variable "dc_2_pgstandby_name" {}

variable "dc_2_pgstandby_count" {
  default = 0
}

variable "dc_2_pgstandby_instance_type" {}

variable "dc_2_pgstandby_disk_size" {
  default = 4000
}

variable "dc_3_region" {
  default = "3"
}

variable "dc_3_ds_name" {}

variable "dc_3_ds_instance_type" {}

variable "dc_3_ds_count" {
  default = 0
}

variable "dc_3_ds_disk_size" {
  default = 250
}

variable "dc_3_rmp_name" {}

variable "dc_3_rmp_count" {
  default = 0
}

variable "dc_3_rmp_instance_type" {}

variable "dc_3_rmp_disk_size" {
  default = 100
}

variable "dc_3_qpid_name" {}

variable "dc_3_qpid_count" {
  default = 0
}

variable "dc_3_qpid_disk_size" {
  default = 500
}

variable "dc_3_qpid_instance_type" {}

variable "pg_only_name" {}

variable "pg_only_count" {
  default = 1
}

variable "pg_only_instance_type" {}

variable "pg_only_disk_size" {
  default = 4000
}

variable "dev_portal_name" {}

variable "dev_portal_instance_type" {}

variable "dev_portal_count" {
  default = 0
}

variable "dev_portal_disk_size" {
  default = 100
}

variable "credentials_file" { }

variable "gcp_project_name" { }

variable "service_account_email" { }

variable "nat_dc_2_count" {
  default = "0"
}