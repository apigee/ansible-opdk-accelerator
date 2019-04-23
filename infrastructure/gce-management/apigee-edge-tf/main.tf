# Create the apigeenet network
resource "google_compute_network" "apigeenet" {
  name                    = "apigeenet"
  auto_create_subnetworks = "true"
}

# Create managementsubnet-us subnetwork
//resource "google_compute_subnetwork" "apigeenetsubnet-us" {
//  name          = "apigeesubnet-us"
//  region        = "us-central1"
//  network       = "${google_compute_network.apigeenet.self_link}"
//  ip_cidr_range = "10.130.0.0/20"
//}

# Add a firewall rule to allow HTTP, SSH, and RDP traffic on apigeenet
resource "google_compute_firewall" "apigeenet-allow-icmp" {
  name    = "apigeenet-allow-icmp"
  network = "${google_compute_network.apigeenet.self_link}"
  source_ranges = "10.0.0.0/8"
  allow {
    protocol = "icmp"
  }
}

# Add a firewall rule to allow HTTP, SSH, and RDP traffic on apigeenet
resource "google_compute_firewall" "apigeenet-allow-ssh" {
  name    = "apigeenet-allow-ssh"
  network = "${google_compute_network.apigeenet.self_link}"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# Add a firewall rule to allow HTTP, SSH, and RDP traffic on apigeenet
resource "google_compute_firewall" "apigeenet-allow-mgmt-ui" {
  name    = "apigeenet-allow-mgmt-ui"
  network = "${google_compute_network.apigeenet.self_link}"
  allow {
    protocol = "tcp"
    ports    = ["9000"]
  }
}

# Add an apigee-vm instance
module "apigee-vm-0" {
  source              = "./tfnet/instance"
  instance_name       = "planet-edge-dc-1-ms-dc-1-ldap-dc-1-ds-1"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_network.apigeenet.self_link}"
  instance_tags       = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
  ]
}

# Add an apigee-vm instance
module "apigee-vm-1" {
  source              = "./tfnet/instance"
  instance_name       = "planet-edge-dc-1-ds-dc-1-rmp-1"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_network.apigeenet.self_link}"
  instance_tags       = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
  ]
}

# Add an apigee-vm instance
module "apigee-vm-2" {
  source              = "./tfnet/instance"
  instance_name       = "planet-edge-dc-1-ds-dc-1-rmp-2"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_network.apigeenet.self_link}"
  instance_tags       = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
  ]
}

# Add an apigee-vm instance
module "apigee-vm-3" {
  source              = "./tfnet/instance"
  instance_name       = "planet-edge-dc-1-pg-dc-1-pgmaster-dc-1-qpid-1"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_network.apigeenet.self_link}"
  instance_tags       = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
  ]
}

# Add an apigee-vm instance
module "apigee-vm-4" {
  source              = "./tfnet/instance"
  instance_name       = "planet-edge-dc-1-pg-dc-1-pgstandby-dc-1-qpid-2"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_network.apigeenet.self_link}"
  instance_tags       = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
  ]
}
