# Create the apigeenet network
resource "google_compute_network" "apigeenet" {
  name                    = "apigeenet"
  auto_create_subnetworks = true
}

# Create the apigeenet router
resource "google_compute_router" "apigeenet-router" {
  name    = "apigeenet-router"
  network = "${google_compute_network.apigeenet.self_link}"
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
  name = "apigeenet-subnet-nat-dc-2"
  //  router                             = "us-east1/apigeenet"
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
module "apigee-bastion-vm" {
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
module "apigee-vm-dc-1-ms" {
  source             = "../modules/internal-instance"
  instance_name      = "planet-dc-1-ms-dc-1-ldap-dc-1-ui"
  instance_count     = "1"
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
module "apigee-vm-dc-2-ms" {
  source             = "../modules/internal-instance"
  instance_name      = "planet-dc-2-ms-dc-2-ldap-dc-2-ui"
  instance_count     = "0"
  instance_zone      = "us-central1-f"
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
module "apigee-vm-dc-1-ds" {
  source             = "../modules/internal-instance"
  instance_zone      = "${var.zone}"
  instance_count     = 3
  instance_name      = "planet-dc-1-ds"
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
module "apigee-vm-dc-2-ds" {
  source             = "../modules/internal-instance"
  instance_zone      = "us-central1-f"
  instance_count     = 0
  instance_name      = "planet-dc-2-ds"
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
module "apigee-vm-dc-1-rmp" {
  source             = "../modules/internal-instance"
  instance_name      = "planet-dc-1-rmp"
  instance_count     = "2"
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
module "apigee-vm-dc-2-rmp" {
  source             = "../modules/internal-instance"
  instance_name      = "planet-dc-2-rmp"
  instance_count     = "0"
  instance_zone      = "us-central1-f"
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

//# Add an apigee-vm instance
module "apigee-vm-dc-1-qpid" {
  source             = "../modules/internal-instance"
  instance_zone      = "${var.zone}"
  instance_name      = "planet-dc-1-qpid"
  instance_count     = "2"
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

//# Add an apigee-vm instance
module "apigee-vm-dc-2-qpid" {
  source             = "../modules/internal-instance"
  instance_zone      = "us-central1-f"
  instance_name      = "planet-dc-2-qpid"
  instance_count     = "0"
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
module "apigee-vm-dc-1-pgmaster" {
  source             = "../modules/internal-instance"
  instance_name      = "planet-dc-1-pg-dc-1-pgmaster"
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
module "apigee-vm-dc-1-pgstandby" {
  source             = "../modules/internal-instance"
  instance_name      = "planet-dc-1-pg-dc-1-pgstandby"
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
module "apigee-vm-dc-2-pgstandby" {
  source             = "../modules/internal-instance"
  instance_name      = "planet-dc-2-pg-dc-2-pgstandby"
  instance_count     = "0"
  instance_zone      = "us-central1-f"
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

