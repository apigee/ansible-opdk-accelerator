# Create the apigeenet network
resource "google_compute_network" "apigeenet" {
  name                    = "apigeenet"
  auto_create_subnetworks = "true"
}

# Create apigeenet-subnet-router
resource "google_compute_router" "apigeenet-subnet-router" {
  name    = "apigeenet-subnet-router"
  region  = "us-east1"
  network = "${google_compute_network.apigeenet.self_link}"

  bgp {
    asn = 64514
  }
}

# Create the gateway nat for the apigeenet-subnet-router
resource "google_compute_router_nat" "apigeenet-subnet-nat" {
  name                               = "apigeenet-subnet-nat"
  router                             = "${google_compute_router.apigeenet-subnet-router.name}"
  region                             = "us-east1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# Reserve an external address
//resource "google_compute_global_address" "apigeenet-ms-global-address" {
//  name = "apigeenet-ms-global-address"
//}

//output "ms_global_address" {
//  value = "${google_compute_global_address.apigeenet-ms-global-address.address}"
//}

# Create the global forwarding rule for Apigee MS
//resource "google_compute_global_forwarding_rule" "apigeenet-ms-forwarding-rule" {
//  name       = "apigeenet-ms-forwarding-rule"
//  port_range = "80"
//  ip_address = "${google_compute_global_address.apigeenet-ms-global-address.address}"
//  target     = "${google_compute_target_http_proxy.apigeenet-ms-http-proxy.self_link}"
//}

//resource "google_compute_target_http_proxy" "apigeenet-ms-http-proxy" {
//  name    = "apigeenet-ms-http-proxy"
//  url_map = "${google_compute_url_map.apigeenet-ms-url-map.self_link}"
//}

//resource "google_compute_url_map" "apigeenet-ms-url-map" {
//  name            = "apigeenet-ms-url-map"
//  default_service = "${google_compute_backend_service.apigeenet-ms-backend-service.self_link}"
//}

//resource "google_compute_backend_service" "apigeenet-ms-backend-service" {
//  name             = "apigeenet-ms-backend-service"
//  protocol         = "HTTP"
//  port_name        = "apigeenet-ms-ui-port"
//  timeout_sec      = 10
//  session_affinity = "NONE"
//
//  backend {
//    group = "${google_compute_region_instance_group_manager.apigeenet-ms-group-instance.instance_group}"
//  }
//
//  health_checks = [
//    "${google_compute_http_health_check.apigeenet-ms-http-health-check.self_link}",
//  ]
//}

//resource "google_compute_http_health_check" "apigeenet-ms-http-health-check" {
//  name               = "apigeenet-ms-http-health-check"
//  request_path       = "/v1/servers/self/up"
//  timeout_sec        = 1
//  check_interval_sec = 1
//}

module "configure_apigeenet_firewalls_icmp" {
  source                 = "apigeenet-firewalls-protocol-only"
  firewall_name          = "apigeenet-allow-icmp"
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "icmp"
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_apigeenet_firewalls_ssh" {
  source                 = "apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "apigeenet-allow-ssh"
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["22"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_apigeenet_firewalls_mgmt_ui" {
  source                 = "apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "apigeenet-allow-mgmt-ui"
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["9000"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_apigeenet_firewalls_rmp" {
  source                 = "apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "apigeenet-allow-rmp"
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["9001"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "create-ms-ldap-ui-instance-template" {
  source                  = "apigeenet-instance-group-manager"
  instance_name           = "planet-group-dc-1-ms-dc-1-ldap-dc-1-ui"
  instance_network        = "${google_compute_network.apigeenet.name}"
  instance_count          = "1"
  instance_size           = "60"
  instance_tags           = ["apigeenet-allow-ssh", "apigeenet-allow-mgmt-ui"]
  group_manager_name      = "ms-ldap-ui-region-instance-group-manager"
  group_manager_port      = "9000"
  group_manager_port_name = "apigee-ms-ui-port"
}

module "create-rmp-instance-template" {
  source                  = "apigeenet-instance-group-manager"
  instance_name           = "planet-dc-1-ds-dc-1-rmp"
  instance_network        = "${google_compute_network.apigeenet.name}"
  instance_count          = "2"
  instance_size           = "60"
  instance_tags           = ["apigeenet-allow-ssh", "apigeenet-allow-rmp"]
  group_manager_name      = "planet-dc-1-ds-dc-1-rmp-1"
  group_manager_port      = "9001"
  group_manager_port_name = "apigee-rmp-vh-port"
}

//resource "google_compute_region_instance_group_manager" "apigeenet-ms-group-instance" {
//  name                      = "ms-ldap-ui-region-instance-group-manager"
//  base_instance_name        = "${google_compute_instance_template.apigeenet-ms-instance-template.name}"
//  region                    = "us-east1"
//  instance_template         = "${google_compute_instance_template.apigeenet-ms-instance-template.self_link}"
//  distribution_policy_zones = ["us-east1-d"]
//  target_size               = 1
//
//  named_port {
//    name = "apigeenet-ms-ui-port"
//    port = 9000
//  }
//}

//resource "google_compute_instance_template" "apigeenet-ms-instance-template" {
//  name           = "planet-group-dc-1-ms-dc-1-ldap-dc-1-ui"
//  machine_type   = "n1-standard-1"
//  can_ip_forward = false
//
//  network_interface {
//    network       = "${google_compute_network.apigeenet.name}"
//    access_config = {}
//  }
//
//  disk {
//    auto_delete = true
//    boot        = true
//
//    source_image = "${data.google_compute_image.apigeenet-base-system-image.self_link}"
//    disk_size_gb = 60
//    disk_type    = "pd-ssd"
//  }
//}
//
//data "google_compute_image" "apigeenet-base-system-image" {
//  name    = "centos-7-v20190423"
//  project = "centos-cloud"
//}

//# Add an apigee-vm instance
module "apigee-bastion-vm" {
  source           = "./external-instance"
  instance_name    = "apigee-bastion"
  instance_zone    = "us-east1-d"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
  ]

  instance_external_ip  = "Ephemeral"
  instance_scopes       = ["compute-rw", "storage-ro"]
  service_account_email = "313223894095-compute@developer.gserviceaccount.com"
}

# Add an apigee-vm instance
module "apigee-vm-1" {
  source           = "./internal-instance"
  instance_name    = "planet-dc-1-ds-1"
  instance_zone    = "us-east1-d"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
  ]
}

# Add an apigee-vm instance
//module "apigee-vm-2" {
//  source           = "./internal-instance"
//  instance_name    = "planet-dc-1-ds-dc-1-rmp-1"
//  instance_zone    = "us-east1-d"
//  instance_network = "${google_compute_network.apigeenet.self_link}"
//
//  instance_tags = [
//    "apigeenet-allow-ssh",
//    "apigeenet-allow-icmp",
//    "apigeenet-allow-rmp",
//  ]
//}

//# Add an apigee-vm instance
//module "apigee-vm-3" {
//  source           = "./internal-instance"
//  instance_zone    = "us-east1-d"
//  instance_name    = "planet-dc-1-ds-dc-1-rmp-2"
//  instance_network = "${google_compute_network.apigeenet.self_link}"
//
//  instance_tags = [
//    "apigeenet-allow-ssh",
//    "apigeenet-allow-icmp",
//    "apigeenet-allow-rmp",
//  ]
//}

# Add an apigee-vm instance
module "apigee-vm-4" {
  source           = "./internal-instance"
  instance_name    = "planet-dc-1-pg-dc-1-pgmaster-dc-1-qpid-1"
  instance_zone    = "us-east1-d"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
  ]
}

# Add an apigee-vm instance
module "apigee-vm-5" {
  source           = "./internal-instance"
  instance_name    = "planet-dc-1-pg-dc-1-pgstandby-dc-1-qpid-2"
  instance_zone    = "us-east1-d"
  instance_network = "${google_compute_network.apigeenet.self_link}"

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
  ]
}
