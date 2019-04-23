# Create the apigeenet network
resource "google_compute_network" "apigeenet" {
  name                    = "apigeenet"
  auto_create_subnetworks = "true"
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

# Add an apigee-vm instance
module "apigee-vm-0" {
  source              = "./tfnet/instance"
  instance_name       = "cf-000"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_subnetwork.apigeenetsubnet-us.self_link}"
}

# Add an apigee-vm instance
module "apigee-vm-1" {
  source              = "./tfnet/instance"
  instance_name       = "cf-001"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_subnetwork.apigeenetsubnet-us.self_link}"
}

# Add an apigee-vm instance
module "apigee-vm-2" {
  source              = "./tfnet/instance"
  instance_name       = "cf-002"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_subnetwork.apigeenetsubnet-us.self_link}"
}

# Add an apigee-vm instance
module "apigee-vm-3" {
  source              = "./tfnet/instance"
  instance_name       = "cf-003"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_subnetwork.apigeenetsubnet-us.self_link}"
}

# Add an apigee-vm instance
module "apigee-vm-4" {
  source              = "./tfnet/instance"
  instance_name       = "cf-004"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_subnetwork.apigeenetsubnet-us.self_link}"
}

# Add an apigee-vm instance
module "apigee-vm-5" {
  source              = "./tfnet/instance"
  instance_name       = "cf-005"
  instance_zone       = "us-central1-a"
  instance_subnetwork = "${google_compute_subnetwork.apigeenetsubnet-us.self_link}"
}
