# Create the gateway nat for the apigeenet-subnet-router
resource "google_compute_router_nat" "apigeenet-subnet-nat" {
  name                               = "apigeenet-subnet-nat-${var.region}"
  router                             = "${google_compute_router.apigeenet-router.name}"
  region                             = "${var.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

module "apigee-ms-ldap-ui" {
  source             = "../modules/internal-instance"
  instance_count = "${var.ms_count}"
  instance_name      = "${var.ms_name}"
  instance_zone      = "${var.zone}"
  instance_network   = "${google_compute_network.apigeenet.self_link}"
  instance_disk_size = 250
  instance_type      = "${var.machine_type}"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
  ]
}

# Add an apigee-vm instance
module "apigee-rmp" {
  source             = "../modules/internal-instance"
  instance_zone      = "${var.zone}"
  instance_count     = "${var.rmp_count}"
  instance_name      = "${var.rmp_name}"
  instance_network   = "${google_compute_network.apigeenet.self_link}"
  instance_disk_size = 250
  instance_type      = "n1-standard-2"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "validate-rmp"
  ]
}

# Add an apigee-vm instance
module "apigee-ds" {
  source             = "../modules/internal-instance"
  instance_zone      = "${var.zone}"
  instance_count     = "${var.ds_count}"
  instance_name      = "${var.ds_name}"
  instance_network   = "${google_compute_network.apigeenet.self_link}"
  instance_disk_size = 250
  instance_type      = "n1-standard-2"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "validate-rmp"
  ]
}

//# Add an apigee-vm instance
module "apigee-qpid" {
  source             = "../modules/internal-instance"
  instance_zone      = "${var.zone}"
  instance_count     = "${var.qpid_count}"
  instance_name      = "${var.qpid_name}"
  instance_network   = "${google_compute_network.apigeenet.self_link}"
  instance_disk_size = 50
  instance_type      = "n1-standard-2"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql"
  ]
}

# Add an apigee-vm instance
module "apigee-pg-only" {
  source             = "../modules/internal-instance"
  instance_name      = "${var.pg_only_name}"
  instance_count     = "${var.pg_only_count}"
  instance_zone      = "${var.zone}"
  instance_network   = "${google_compute_network.apigeenet.self_link}"
  instance_disk_size = 250
  instance_type      = "n1-standard-2"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql"
  ]
}

# Add an apigee-vm instance
module "apigee-pg-pgmaster" {
  source             = "../modules/internal-instance"
  instance_name      = "${var.pgmaster_name}"
  instance_count     = "${var.pgmaster_count}"
  instance_zone      = "${var.zone}"
  instance_network   = "${google_compute_network.apigeenet.self_link}"
  instance_disk_size = 250
  instance_type      = "n1-standard-2"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql"
  ]
}


# Add an apigee-vm instance
module "apigee-pg-pgstandby" {
  source             = "../modules/internal-instance"
  instance_name      = "${var.pgstandby_name}"
  instance_count     = "${var.pgstandby_count}"
  instance_zone      = "${var.zone}"
  instance_network   = "${google_compute_network.apigeenet.self_link}"
  instance_disk_size = 250
  instance_type      = "n1-standard-2"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql"
  ]
}

# Add an apigee-vm instance
module "apigee-dp" {
  source             = "../modules/internal-instance"
  instance_name      = "${var.dev_portal_name}"
  instance_count     = "${var.dev_portal_count}"
  instance_zone      = "${var.zone}"
  instance_network   = "${google_compute_network.apigeenet.self_link}"
  instance_disk_size = 250
  instance_type      = "n1-standard-2"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql"
  ]
}

