# Create the apigeenet network
resource "google_compute_network" "apigeenet" {
  name                    = "apigeenet"
  auto_create_subnetworks = true
}

# Create the apigeenet router
resource "google_compute_router" "apigeenet-router" {
  name    = "apigeenet-router"
  network = "${google_compute_network.apigeenet.self_link}"
  region  = "us-east1"
}

# Create the apigeenet router
resource "google_compute_router" "apigeenet-central-router" {
  name    = "apigeenet-router"
  network = "${google_compute_network.apigeenet.self_link}"
  region  = "us-central1"
}

# Create the gateway nat for the apigeenet-subnet-router
resource "google_compute_router_nat" "apigeenet-subnet-nat" {
  name                               = "apigeenet-subnet-nat"
  router                             = "${google_compute_router.apigeenet-router.name}"
  region                             = "${var.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
# Create the gateway nat for the apigeenet-subnet-router
resource "google_compute_router_nat" "apigeenet-subnet-nat-dc-2" {
  name                               = "apigeenet-subnet-nat-dc-2"
  count                              = "${var.nat_dc_2_count}"
  router                             = "${google_compute_router.apigeenet-central-router.name}"
  region                             = "us-central1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

module "configure_firewall_apigeenet_allow_mgmt_ui" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "mgmt-ui"
  firewall_source_tags   = ["mgmt-ui"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["9000", "80", "8080", "9001"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_validate_test" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "validate-rmp"
  firewall_source_tags   = ["validate-rmp"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["59001"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_postgresql_testing" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "postgresql"
  firewall_source_tags   = ["postgresql"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["5432"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_icmp" {
  source                 = "../modules/apigeenet-firewalls-protocol-only"
  firewall_name          = "apigeenet-allow-icmp"
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "icmp"
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_ssh" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "apigeenet-allow-ssh"
  firewall_source_tags   = ["apigeenet-allow-ssh"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["22"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_public_allow_ssh" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "public-allow-ssh"
  firewall_source_tags   = ["public-allow-ssh"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["22"]
  firewall_source_ranges = ["0.0.0.0/0"]
}

module "configure_firewall_apigeenet_allow_local" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "apigeenet-allow-local"
  firewall_source_tags   = ["apigeenet-allow-local"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["0-65535"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

//# Add an apigee-vm instance
module "apigee-bastion" {
  source           = "../modules/external-instance"
  instance_name    = "apigee-bastion"
  instance_zone    = "${var.zone}"
  instance_network = "${google_compute_network.apigeenet.self_link}"
  instance_type    = "n1-standard-1"

  instance_tags = [
    "apigeenet-allow-icmp",
    "public-allow-ssh",
    "apigeenet-allow-local",
    "g-on-g-notify-ignore",
  ]

  instance_external_ip = "Ephemeral"
  instance_scopes      = ["compute-rw", "storage-ro"]
}

# Add an apigee-vm instance
module "apigee-dc-1-ms-ldap-ui" {
  source             = "../modules/internal-instance"
  instance_name      = "planet-dc-1-ms-dc-1-ldap-dc-1-ui-dc-1-ds"
  instance_zone      = "${var.zone}"
  instance_network   = "${google_compute_network.apigeenet.self_link}"
  instance_disk_size = 250
  instance_type      = "n1-standard-2"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
  ]
}

# Add an apigee-vm instance
module "apigee-dc-1-ds" {
  source             = "../modules/internal-instance"
  instance_zone      = "${var.zone}"
  instance_name      = "planet-dc-1-ds-dc-1-rmp"
  instance_count     = "2"
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
module "apigee-dc-1-qpid-pg" {
  source             = "../modules/internal-instance"
  instance_zone      = "${var.zone}"
  instance_name      = "planet-dc-1-qpid-dc-1-pg"
  instance_count     = "${var.dc_1_pg_only_count}"
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

//# Add an apigee-vm instance
module "apigee-dc-1-qpid-pg-pgmaster" {
  source             = "../modules/internal-instance"
  instance_zone      = "${var.zone}"
  instance_count     = "${var.dc_1_pgmaster_count}"
  instance_name      = "planet-dc-1-qpid-dc-1-pg-dc-1-pgmaster"
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
module "apigee-dc-1-qpid-pg-pgstandby" {
  source             = "../modules/internal-instance"
  instance_name      = "planet-dc-1-qpid-dc-1-pg-dc-1-pgstandby"
  instance_zone      = "${var.zone}"
  instance_count     = "${var.dc_1_pgstandby_count}"
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
