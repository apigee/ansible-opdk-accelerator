# Create the apigeenet network
resource "google_compute_network" "apigeenet" {
  name                    = "apigeenet"
  auto_create_subnetworks = "true"
}

# Create apigeenet-subnet-router
resource "google_compute_router" "apigee-subnet-router" {
  name    = "apigee-subnet-router"
  region  = "us-central1"
  network = "${google_compute_network.apigeenet.self_link}"

  bgp {
    asn = 64514
  }
}

# Create the gateway nat for the apigee-subnet-router
resource "google_compute_router_nat" "apigeenet-subnet-gateway-nat" {
  name                               = "apigeenet-subnet-gateway-nat"
  router                             = "${google_compute_router.apigee-subnet-router.name}"
  region                             = "us-central1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# Reserve an external address
resource "google_compute_global_address" "apigeenet-ms" {
  name = "apigeenet-ms"
}

output "global_address" {
  value = "${google_compute_global_address.apigeenet-ms.address}"
}

# Create the global forwarding rule for Apigee MS
resource "google_compute_global_forwarding_rule" "apigeenet-ms" {
  name       = "apigeenet-ms"
  port_range = "80"
  ip_address = "${google_compute_global_address.apigeenet-ms.address}"
  target     = "${google_compute_target_http_proxy.apigeenet-ms.self_link}"
}

resource "google_compute_target_http_proxy" "apigeenet-ms" {
  name    = "apigeenet-ms"
  url_map = "${google_compute_url_map.apigeenet-ms.self_link}"
}

resource "google_compute_url_map" "apigeenet-ms" {
  name            = "apigeenet-ms"
  default_service = "${google_compute_backend_service.apigeenet-ms.self_link}"
}

resource "google_compute_backend_service" "apigeenet-ms" {
  name             = "apigeenet-ms"
  protocol         = "HTTP"
  port_name        = "apigeenet-allow-mgmt-ui"
  timeout_sec      = 10
  session_affinity = "NONE"

  backend {
    group = "${google_compute_region_instance_group_manager.apigeenet-ms.instance_group}"
  }

  health_checks = [
    "${google_compute_http_health_check.apigeenet-ms.self_link}",
  ]
}

resource "google_compute_http_health_check" "apigeenet-ms" {
  name               = "apigeenet-ms"
  request_path       = "/"
  timeout_sec        = 1
  check_interval_sec = 1
}

resource "google_compute_region_instance_group_manager" "apigeenet-ms" {
  name                      = "planet-group-dc-1-ms-dc-1-ldap-dc-1-ui"
  base_instance_name        = "planet-group-dc-1-ms-dc-1-ldap-dc-1-ui"
  region                    = "us-central1"
  instance_template         = "${google_compute_instance_template.apigeenet-ms.self_link}"
  distribution_policy_zones = ["us-central1-a"]
  target_size               = 1

  named_port {
    name = "apigeenet-ms"
    port = 9001
  }
}

resource "google_compute_instance_template" "apigeenet-ms" {
  name           = "planet-dc-1-ms-dc-1-ldap-dc-1-ui"
  machine_type   = "n1-standard-1"
  can_ip_forward = false

  network_interface {
    network       = "${google_compute_network.apigeenet.name}"
    access_config = {}
  }

  disk {
    auto_delete = true
    boot        = true

    //    source      = "${google_compute_disk.apigeenet-ms.name}"
    source_image = "${data.google_compute_image.apigeenet-ms.self_link}"
    disk_size_gb = 60
    disk_type    = "pd-ssd"
  }
}

resource "google_compute_disk" "apigeenet-ms" {
  name  = "planet-dc-1-ms-dc-1-ldap-dc-1-ui"
  image = "${data.google_compute_image.apigeenet-ms.self_link}"
  size  = 60
  type  = "pd-ssd"
  zone  = "us-central1-a"
}

data "google_compute_image" "apigeenet-ms" {
  name    = "centos-7-v20190423"
  project = "centos-cloud"
}

# Add a firewall rule to allow HTTP, SSH, and RDP traffic on apigeenet
resource "google_compute_firewall" "apigeenet-allow-tcp-icmp" {
  name    = "apigeenet-allow-icmp-tcp"
  network = "${google_compute_network.apigeenet.self_link}"

  source_ranges = [
    "10.0.0.0/8",
  ]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
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

//# Add an apigee-vm instance
module "apigee-bastion-vm" {
  source           = "./external-instance"
  instance_name    = "apigee-bastion"
  instance_zone    = "us-central1-a"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp-tcp",
  ]

  instance_external_ip  = "Ephemeral"
  instance_scopes       = ["compute-rw", "storage-ro"]
  service_account_email = "736255665193-compute@developer.gserviceaccount.com"
}

# Add an apigee-vm instance
module "apigee-vm-1" {
  source           = "./internal-instance"
  instance_name    = "planet-dc-1-ds-1"
  instance_zone    = "us-central1-a"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp-tcp",
    "apigeenet-allow-mgmt-ui",
  ]
}

# Add an apigee-vm instance
module "apigee-vm-2" {
  source           = "./internal-instance"
  instance_name    = "planet-dc-1-ds-dc-1-rmp-1"
  instance_zone    = "us-central1-a"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp-tcp",
  ]
}

# Add an apigee-vm instance
module "apigee-vm-3" {
  source           = "./internal-instance"
  instance_zone    = "us-central1-a"
  instance_name    = "planet-dc-1-ds-dc-1-rmp-2"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp-tcp",
  ]
}

# Add an apigee-vm instance
module "apigee-vm-4" {
  source           = "./internal-instance"
  instance_name    = "planet-dc-1-pg-dc-1-pgmaster-dc-1-qpid-1"
  instance_zone    = "us-central1-a"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp-tcp",
  ]
}

# Add an apigee-vm instance
module "apigee-vm-5" {
  source           = "./internal-instance"
  instance_name    = "planet-dc-1-pg-dc-1-pgstandby-dc-1-qpid-2"
  instance_zone    = "us-central1-a"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp-tcp",
  ]
}
