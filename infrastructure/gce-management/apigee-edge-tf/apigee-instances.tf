# Create the apigeenet network
resource "google_compute_network" "apigeenet" {
  name                    = "apigee-net"
  auto_create_subnetworks = "false"
}

# Create managementsubnet-us subnetwork
resource "google_compute_subnetwork" "apigeenetsubnet-us" {
  name          = "apigeesubnet-us"
  region        = "us-central1"
  network       = "${google_compute_network.apigeenet.self_link}"
  ip_cidr_range = "10.130.0.0/20"
}

# Add a firewall rule to allow HTTP, SSH, and RDP traffic on managementnet
resource "google_compute_firewall" "apigeenet-allow-http-ssh-rdp-icmp" {
  name    = "apigeenet-allow-http-ssh-rdp-icmp"
  network = "${google_compute_network.apigeenet.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }

  allow {
    protocol = "icmp"
  }
}

# Add the managementnet-us-vm instance
module "apigee-vm" {
  source              = "./tfnet/instance"
  instance_name       = "apigee-edge-vm"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_subnetwork.apigeenetsubnet-us.self_link}"
}
