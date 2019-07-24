# Create the apigeenet network
resource "google_compute_network" "apigeenet" {
  name = "apigeenet-prod"
}

# Create the apigeenet router
resource "google_compute_router" "apigeenet-router" {
  name    = "apigeenet-prod-router"
  network = "${google_compute_network.apigeenet.self_link}"
}

# Create the gateway nat for the apigeenet-subnet-router
resource "google_compute_router_nat" "apigeenet-subnet-nat" {
  name = "apigeenet-prod-subnet-nat"
  router                             = "${google_compute_router.apigeenet-router.name}"
  region                             = "${var.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# Reserve an external address
resource "google_compute_global_address" "apigeenet-ms-global-address" {
  name = "apigeenet-ms-global-address"
}

# Create the global forwarding rule for Apigee MS
resource "google_compute_global_forwarding_rule" "apigeenet-ms-forwarding-rule" {
  name       = "apigeenet-ms-forwarding-rule"
  port_range = "80"
  ip_address = "${google_compute_global_address.apigeenet-ms-global-address.address}"
  target     = "${google_compute_target_http_proxy.apigeenet-ms-http-proxy.self_link}"
}

resource "google_compute_target_http_proxy" "apigeenet-ms-http-proxy" {
  name    = "apigeenet-ms-http-proxy"
  url_map = "${google_compute_url_map.apigeenet-ms-url-map.self_link}"
}

resource "google_compute_url_map" "apigeenet-ms-url-map" {
  name            = "apigeenet-ms-url-map"
  default_service = "${google_compute_backend_service.apigeenet-ms-ui-backend-service.self_link}"
}

resource "google_compute_backend_service" "apigeenet-ms-ui-backend-service" {
  name     = "apigeenet-ms-ui-backend-service"
  protocol = "HTTP"

  port_name = "${var.apigee_ms_ui_port_name}"

  timeout_sec      = 10
  session_affinity = "NONE"

  backend {
    group = "${module.create-aio-ui-instance-group-manager.instance_group}"
  }

  health_checks = [
    "${google_compute_health_check.apigeenet-ms-ui-health-check.self_link}"
  ]
}

resource "google_compute_health_check" "apigeenet-ms-ui-health-check" {
  name               = "apigeenet-ms-ui-health-check"
  timeout_sec        = 5
  check_interval_sec = 21

  http_health_check {
    port         = "${var.apigee_ms_ui_port}"
    request_path = "/login"
  }
}

//resource "google_compute_backend_service" "apigeenet-ms-api-backend-service" {
//  name     = "apigeenet-ms-api-backend-service"
//  protocol = "HTTP"
//
//  port_name = "${var.apigee_ms_api_port_name}"
//
//  timeout_sec      = 10
//  session_affinity = "NONE"
//
//  backend {
//    group = "${module.create-aio-ui-instance-group-manager.instance_group}"
//  }
//
//  health_checks = [
//    "${google_compute_health_check.apigeenet-ms-api-health-check.self_link}",
//  ]
//}
//
//resource "google_compute_health_check" "apigeenet-ms-api-health-check" {
//  name               = "apigeenet-ms-api-health-check"
//  timeout_sec        = 5
//  check_interval_sec = 21
//
//  http_health_check {
//    port         = "${var.apigee_ms_api_port}"
//    request_path = "/v1/servers/self/up"
//    response     = ""
//  }
//}

//module "configure_firewall_apigeenet_allow_icmp" {
//  source                 = "apigeenet-firewalls-protocol-only"
//  firewall_name          = "apigeenet-allow-icmp"
//  firewall_network       = "${google_compute_network.apigeenet.self_link}"
//  firewall_protocol      = "icmp"
//  firewall_source_ranges = ["10.0.0.0/8"]
//}
//
//module "configure_firewall_apigeenet_allow_ssh" {
//  source                 = "apigeenet-firewalls-protocol-with-ports"
//  firewall_name          = "apigeenet-allow-ssh"
//  firewall_network       = "${google_compute_network.apigeenet.self_link}"
//  firewall_protocol      = "tcp"
//  firewall_ports         = ["22"]
//  firewall_source_ranges = ["10.0.0.0/8"]
//}

//module "configure_firewall_apigeenet_allow_mgmt_ui" {
//  source                 = "apigeenet-firewalls-protocol-with-ports"
//  firewall_name          = "apigeenet-allow-mgmt-ui"
//  firewall_network       = "${google_compute_network.apigeenet.self_link}"
//  firewall_protocol      = "tcp"
//  firewall_ports         = ["9000", "80", "8080"]
//  firewall_source_ranges = ["10.0.0.0/8"]
//}
//
//module "configure_firewall_apigeenet_allow_rmp" {
//  source                 = "apigeenet-firewalls-protocol-with-ports"
//  firewall_name          = "apigeenet-allow-rmp"
//  firewall_network       = "${google_compute_network.apigeenet.self_link}"
//  firewall_protocol      = "tcp"
//  firewall_ports         = ["9001"]
//  firewall_source_ranges = ["10.0.0.0/8"]
//}
//
//module "configure_firewall_apigeenet_allow_validate_test" {
//  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
//  firewall_name          = "validate-rmp"
//  firewall_source_tags   = ["validate-rmp"]
//  firewall_network       = "${google_compute_network.apigeenet.self_link}"
//  firewall_protocol      = "tcp"
//  firewall_ports         = ["59001"]
//  firewall_source_ranges = ["10.0.0.0/8"]
//}
//
//module "configure_firewall_apigeenet_allow_postgresql_testing" {
//  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
//  firewall_name          = "postgresql"
//  firewall_source_tags   = ["postgresql"]
//  firewall_network       = "${google_compute_network.apigeenet.self_link}"
//  firewall_protocol      = "tcp"
//  firewall_ports         = ["5432"]
//  firewall_source_ranges = ["10.0.0.0/8"]
//}
//
//module "configure_firewall_default_allow_icmp" {
//  source = "apigeenet-firewalls-protocol-only"
//  firewall_name = "default-allow-icmp"
//  firewall_network = "${google_compute_network.apigeenet.self_link}"
//  firewall_protocol = "icmp"
//  firewall_source_ranges = "['0.0.0.0/0']"
//}

//module "configure_firewall_default_allow_internal" {
//  source = "apigeenet-firewalls-protocol-with-ports"
//  firewall_name = "default-allow-internal"
//  firewall_network = "${google_compute_network.apigeenet.self_link}"
//  firewall_protocol = "tcp"
//  firewall_source_ranges = "['10.128.0.0/9']"
//  firewall_ports = ["tcp:0-65535","udp:0-65535","icmp"]
//}

module "create-aio-ui-instance-group-manager" {
  source           = "../modules/apigeenet-instance-group-manager"
  instance_name    = "planet-aio"
  instance_network = "${google_compute_network.apigeenet.name}"
  instance_count   = "1"
  instance_size    = 250

  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
  ]

  group_manager_name      = "aio-region-instance-group-manager"
  group_manager_port      = "${var.apigee_ms_ui_port}"
  group_manager_port_name = "${var.apigee_ms_ui_port_name}"
  machine_type            = "n1-standard-4"

  //  ip_address = "${google_compute_global_address.apigeenet-ms-global-address.address}"
}

//module "create-aio-api-instance-group-manager" {
//  source           = "apigeenet-instance-group-manager"
//  instance_name    = "planet-aio"
//  instance_network = "${data.google_compute_network.apigeenet.name}"
//  instance_count   = "1"
//  instance_size    = "60"
//
//  //  instance_tags           = ["apigeenet-allow-ssh", "apigeenet-allow-mgmt-ui"]
//  instance_tags           = ["http-server", "g-on-g-notify-ignore"]
//  group_manager_name      = "api-region-instance-group-manager"
//  group_manager_port      = "${var.apigee_ms_api_port}"
//  group_manager_port_name = "${var.apigee_ms_api_port_name}"
//  machine_type            = "n1-standard-4"
//
//  //  ip_address = "${google_compute_global_address.apigeenet-ms-global-address.address}"
//}

//module "create-ms-ldap-ui-instance-template" {
//  source                  = "apigeenet-instance-group-manager"
//  instance_name           = "planet-dc-1-ms-dc-1-ldap-dc-1-ui"
//  instance_network        = "${data.google_compute_network.apigeenet.name}"
//  instance_count          = "1"
//  instance_size           = "60"
//  instance_tags           = ["apigeenet-allow-ssh", "apigeenet-allow-mgmt-ui"]
//  group_manager_name      = "ms-ldap-ui-region-instance-group-manager"
//  group_manager_port      = "9000"
//  group_manager_port_name = "${var.apigee_ms_ui_port_name}"
//}

//module "create-rmp-instance-template" {
//  source                  = "apigeenet-instance-group-manager"
//  instance_name           = "planet-dc-1-ds-dc-1-rmp"
//  instance_network        = "${data.google_compute_network.apigeenet.name}"
//  instance_count          = "2"
//  instance_size           = "60"
//  instance_tags           = ["apigeenet-allow-ssh", "apigeenet-allow-rmp"]
//  group_manager_name      = "planet-dc-1-ds-dc-1-rmp-1"
//  group_manager_port      = "9001"
//  group_manager_port_name = "apigee-rmp-vh-port"
//}

//resource "google_compute_region_instance_group_manager" "apigeenet-ms-group-instance" {
//  name                      = "ms-ldap-ui-region-instance-group-manager"
//  base_instance_name        = "${google_compute_instance_template.apigeenet-ms-instance-template.name}"
//  region                    = "${var.region}"
//  instance_template         = "${google_compute_instance_template.apigeenet-ms-instance-template.self_link}"
//  distribution_policy_zones = ["${var.zone}"]
//  target_size               = 1
//
//  named_port {
//    name = "${var.apigee_ms_ui_port_name}"
//    port = 9000
//  }
//}

//resource "google_compute_instance_template" "apigeenet-ms-instance-template" {
//  name           = "planet-group-dc-1-ms-dc-1-ldap-dc-1-ui"
//  machine_type   = "n1-standard-1"
//  can_ip_forward = false
//
//  network_interface {
//    network       = "${data.google_compute_network.apigeenet.name}"
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

//data "google_compute_image" "apigeenet-base-system-image" {
//  name    = "centos-7-v20190423"
//  project = "centos-cloud"
//}

module "configure_firewall_apigeenet_allow_mgmt_ui" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "mgmt-ui"
  firewall_source_tags   = ["mgmt-ui"]
  firewall_network       = "${google_compute_network.apigeenet.self_link}"
  firewall_protocol      = "tcp"
  firewall_ports         = ["9000", "80", "8080", "9001"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

//module "configure_firewall_apigeenet_allow_icmp" {
//  source                 = "apigeenet-firewalls-protocol-only"
//  firewall_name          = "apigeenet-allow-icmp"
//  firewall_network       = "${google_compute_network.apigeenet.self_link}"
//  firewall_protocol      = "icmp"
//  firewall_source_ranges = ["10.0.0.0/8"]
//}

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
  instance_type    = "n1-standard-2"

  instance_tags = [
    "public-allow-ssh",
    "g-on-g-notify-ignore",
    "apigeenet-allow-icmp",
    "apigeenet-allow-local",
  ]

  instance_external_ip = "Ephemeral"
  instance_scopes      = ["compute-rw", "storage-ro"]
}

# Add an apigee-vm instance
//module "apigee-vm-1" {
//  source             = "./internal-instance"
//  instance_name      = "planet-dc-1-ds-dc-1-ms-dc-1-ldap-dc-1-ui-1"
//  instance_zone      = "${var.zone}"
//  instance_network   = "${google_compute_network.apigeenet.self_link}"
//  instance_disk_size = 250
//  instance_type      = "n1-standard-2"
//
//  instance_tags = [
//    "apigeenet-allow-ssh",
//    "apigeenet-allow-icmp",
//    "apigeenet-allow-mgmt-ui",
//    "apigeenet-allow-local",
//  ]
//}


# Add an apigee-vm instance
//module "apigee-vm-2" {
//  source             = "./internal-instance"
//  instance_name      = "planet-dc-1-ds-dc-1-rmp-1"
//  instance_zone      = "${var.zone}"
//  instance_network   = "${google_compute_network.apigeenet.self_link}"
//  instance_disk_size = 250
//  instance_type      = "n1-standard-2"
//
//  instance_tags = [
//    "apigeenet-allow-ssh",
//    "apigeenet-allow-icmp",
//    "apigeenet-allow-mgmt-ui",
//    "apigeenet-allow-local",
//  ]
//}


# Add an apigee-vm instance
//module "apigee-vm-3" {
//  source             = "./internal-instance"
//  instance_zone      = "${var.zone}"
//  instance_name      = "planet-dc-1-ds-dc-1-rmp-2"
//  instance_network   = "${google_compute_network.apigeenet.self_link}"
//  instance_disk_size = 250
//  instance_type      = "n1-standard-2"
//
//  instance_tags = [
//    "apigeenet-allow-ssh",
//    "apigeenet-allow-icmp",
//    "apigeenet-allow-mgmt-ui",
//    "apigeenet-allow-local",
//  ]
//}


# Add an apigee-vm instance
//module "apigee-vm-4" {
//  source             = "./internal-instance"
//  instance_name      = "planet-dc-1-pg-dc-1-pgmaster-dc-1-qpid-1"
//  instance_zone      = "${var.zone}"
//  instance_network   = "${google_compute_network.apigeenet.self_link}"
//  instance_disk_size = 250
//  instance_type      = "n1-standard-2"
//
//  instance_tags = [
//    "apigeenet-allow-ssh",
//    "apigeenet-allow-icmp",
//    "apigeenet-allow-mgmt-ui",
//    "apigeenet-allow-local",
//  ]
//}


# Add an apigee-vm instance
//module "apigee-vm-5" {
//  source             = "./internal-instance"
//  instance_name      = "planet-dc-1-pg-dc-1-pgstandby-dc-1-qpid-2"
//  instance_zone      = "${var.zone}"
//  instance_network   = "${google_compute_network.apigeenet.self_link}"
//  instance_disk_size = 250
//  instance_type      = "n1-standard-2"
//
//  instance_tags = [
//    "apigeenet-allow-ssh",
//    "apigeenet-allow-icmp",
//    "apigeenet-allow-mgmt-ui",
//    "apigeenet-allow-local",
//  ]
//}

