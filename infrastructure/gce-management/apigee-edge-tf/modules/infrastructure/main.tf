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

module "configure_firewall_apigeenet_allow_mgmt_ui" {
  source                 = "../apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "mgmt-ui"
  firewall_source_tags   = ["mgmt-ui"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["9000", "80", "8080", "9001"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_validate_test" {
  source                 = "../apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "validate-rmp"
  firewall_source_tags   = ["validate-rmp"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["59001"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_postgresql_testing" {
  source                 = "../apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "postgresql"
  firewall_source_tags   = ["postgresql"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["5432"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_icmp" {
  source                 = "../apigeenet-firewalls-protocol-only"
  firewall_name          = "apigeenet-allow-icmp"
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "icmp"
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_ssh" {
  source                 = "../apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "apigeenet-allow-ssh"
  firewall_source_tags   = ["apigeenet-allow-ssh"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["22"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_public_allow_ssh" {
  source                 = "../apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "public-allow-ssh"
  firewall_source_tags   = ["public-allow-ssh"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["22"]
  firewall_source_ranges = ["0.0.0.0/0"]
}

module "configure_firewall_apigeenet_allow_local" {
  source                 = "../apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "apigeenet-allow-local"
  firewall_source_tags   = ["apigeenet-allow-local"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["0-65535"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

//# Add an apigee-vm instance
module "apigee-bastion" {
  source           = "../external-instance"
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
