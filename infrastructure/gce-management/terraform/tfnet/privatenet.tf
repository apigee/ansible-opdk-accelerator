# Create privatenet network
resource "google_compute_network" "privatenet" {
  name                    = "privatenet"
  auto_create_subnetworks = false
}

# Create privatesubnet-us subnetwork
resource "google_compute_subnetwork" "privatesubnet-us" {
  name          = "privatesubnet-us"
  region        = "us-central1"
  network       = "${google_compute_network.privatenet.self_link}"
  ip_cidr_range = "172.16.0.0/24"
}

# Create privatesubnet-eu subnetwork
resource "google_compute_subnetwork" "privatesubnet-eu" {
  name          = "privatesubnet-eu"
  region        = "europe-west1"
  network       = "${google_compute_network.privatenet.self_link}"
  ip_cidr_range = "172.20.0.0/24"
}

# Create a firewall rule to allow HTTP, SSH, RDP and ICMP traffic on privatenet
resource "google_compute_firewall" "privatenet-allow-http-ssh-rdp-icmp" {
  name    = "privatenet-allow-http-ssh-rdp-icmp"
  network = "${google_compute_network.privatenet.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }

  allow {
    protocol = "icmp"
  }
}

# Add the privatenet-us-vm instance
module "privatenet-us-vm" {
  source              = "./instance"
  instance_name       = "privatenet-us-vm"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_subnetwork.privatesubnet-us.self_link}"
}
