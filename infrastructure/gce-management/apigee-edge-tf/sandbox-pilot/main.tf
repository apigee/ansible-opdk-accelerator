# Create the apigeenet network
resource "google_compute_network" "apigeenet" {
  name                    = "apigeenet"
  auto_create_subnetworks = true
}

# Create the apigeenet router
resource "google_compute_router" "apigeenet-router-dc-1" {
  name    = "apigeenet-router"
  network = google_compute_network.apigeenet.self_link
  region  = var.dc_1_gcp_region
}

module "configure_firewall_apigeenet_allow_mgmt_ui" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "mgmt-ui"
  firewall_source_tags   = ["mgmt-ui"]
  firewall_network       = google_compute_network.apigeenet.self_link
  firewall_protocol      = "tcp"
  firewall_ports         = ["9000", "80", "8080", "9001"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_validate_test" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "validate-rmp"
  firewall_source_tags   = ["validate-rmp"]
  firewall_network       = google_compute_network.apigeenet.self_link
  firewall_protocol      = "tcp"
  firewall_ports         = ["59001"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_postgresql_testing" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "postgresql"
  firewall_source_tags   = ["postgresql"]
  firewall_network       = google_compute_network.apigeenet.self_link
  firewall_protocol      = "tcp"
  firewall_ports         = ["5432"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_icmp" {
  source                 = "../modules/apigeenet-firewalls-protocol-only"
  firewall_name          = "apigeenet-allow-icmp"
  firewall_network       = google_compute_network.apigeenet.self_link
  firewall_protocol      = "icmp"
  firewall_source_ranges = ["10.0.0.0/8"]
}

module "configure_firewall_apigeenet_allow_ssh" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "apigeenet-allow-ssh"
  firewall_source_tags   = ["apigeenet-allow-ssh"]
  firewall_network       = google_compute_network.apigeenet.self_link
  firewall_protocol      = "tcp"
  firewall_ports         = ["22"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

//module "configure_firewall_apigeenet_allow_iap" {
//  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
//  firewall_name          = "allow-iap"
//  firewall_source_tags   = ["allow-ssh"]
//  firewall_network       = google_compute_network.apigeenet.self_link
//  firewall_protocol      = "tcp"
//  firewall_ports         = ["20","50-60"]
//  firewall_source_ranges = ["35.235.240.0/20"]
//}

module "configure_firewall_public_allow_ssh" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "public-allow-ssh"
  firewall_source_tags   = ["public-allow-ssh"]
  firewall_network       = google_compute_network.apigeenet.self_link
  firewall_protocol      = "tcp"
  firewall_ports         = ["22"]
  firewall_source_ranges = ["0.0.0.0/0"]
}

module "configure_firewall_apigeenet_allow_local" {
  source                 = "../modules/apigeenet-firewalls-protocol-with-ports"
  firewall_name          = "apigeenet-allow-local"
  firewall_source_tags   = ["apigeenet-allow-local"]
  firewall_network       = google_compute_network.apigeenet.self_link
  firewall_protocol      = "tcp"
  firewall_ports         = ["0-65535"]
  firewall_source_ranges = ["10.0.0.0/8"]
}

//# Add an apigee-vm instance
module "apigee-bastion" {
  source           = "../modules/external-instance"
  instance_name    = "apigee-bastion"
  instance_zone    = var.dc_1_zone
  instance_network = google_compute_network.apigeenet.self_link
  instance_type    = "n1-standard-1"
  instance_tags = [
    "apigeenet-allow-icmp",
    "public-allow-ssh",
    "apigeenet-allow-local",
    "g-on-g-notify-ignore",
    "https-server"
  ]
  instance_external_ip = "Ephemeral"
  instance_scopes      = ["compute-rw", "storage-ro"]
}

# Create the gateway nat for the apigeenet-subnet-router
resource "google_compute_router_nat" "apigeenet-subnet-nat-dc-1" {
  name                               = "apigeenet-subnet-nat-${var.dc_1_region}"
  router                             = google_compute_router.apigeenet-router-dc-1.name
  region                             = var.dc_1_gcp_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

module "apigee-dc-1-ms-ldap-ui" {
  source             = "../modules/internal-instance"
  instance_count     = var.dc_1_ms_count
  instance_name      = var.dc_1_ms_name
  instance_zone      = var.dc_1_zone
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_1_ms_disk_size
  instance_type      = var.dc_1_ms_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "apigee-ms"
  ]
}

module "apigee-dc-2-ms-ldap-ui" {
  source             = "../modules/internal-instance"
  instance_count     = var.dc_2_ms_count
  instance_name      = var.dc_2_ms_name
  instance_zone      = var.dc_2_zone
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_2_ms_disk_size
  instance_type      = var.dc_2_ms_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "apigee-ms"
  ]
}

# Add an apigee-vm instance
module "apigee-dc-1-rmp" {
  source             = "../modules/internal-instance"
  instance_zone      = var.dc_1_zone
  instance_count     = var.dc_1_rmp_count
  instance_name      = var.dc_1_rmp_name
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_1_rmp_disk_size
  instance_type      = var.dc_1_rmp_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "validate-rmp",
    "apigee-rmp"
  ]
}
module "apigee-dc-2-rmp" {
  source             = "../modules/internal-instance"
  instance_zone      = var.dc_2_zone
  instance_count     = var.dc_2_rmp_count
  instance_name      = var.dc_2_rmp_name
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_2_rmp_disk_size
  instance_type      = var.dc_2_rmp_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "validate-rmp",
    "apigee-rmp"
  ]
}
module "apigee-dc-3-rmp" {
  source             = "../modules/internal-instance"
  instance_zone      = var.dc_3_zone
  instance_count     = var.dc_3_rmp_count
  instance_name      = var.dc_3_rmp_name
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_3_rmp_disk_size
  instance_type      = var.dc_3_rmp_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "validate-rmp",
    "apigee-rmp"
  ]
}

# Add an apigee-vm instance
module "apigee-ds-dc-1" {
  source             = "../modules/internal-instance"
  instance_zone      = var.dc_1_zone
  instance_count     = var.dc_1_ds_count
  instance_name      = var.dc_1_ds_name
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_1_ds_disk_size
  instance_type      = var.dc_1_ds_instance_type
  instance_disk_type = "pd-ssd"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "validate-rmp",
    "apigee-ds"
  ]
}
module "apigee-ds-dc-2" {
  source             = "../modules/internal-instance"
  instance_zone      = var.dc_2_zone
  instance_count     = var.dc_2_ds_count
  instance_name      = var.dc_2_ds_name
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_2_ds_disk_size
  instance_type      = var.dc_2_ds_instance_type
  instance_disk_type = "pd-ssd"
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "validate-rmp",
    "apigee-ds"
  ]
}
module "apigee-ds-dc-3" {
  source             = "../modules/internal-instance"
  instance_zone      = var.dc_3_zone
  instance_count     = var.dc_3_ds_count
  instance_name      = var.dc_3_ds_name
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_3_ds_disk_size
  instance_disk_type = "pd-ssd"
  instance_type      = var.dc_3_ds_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "validate-rmp",
    "apigee-ds"
  ]
}

//# Add an apigee-vm instance
module "apigee-qpid-dc-1" {
  source             = "../modules/internal-instance"
  instance_zone      = var.dc_1_zone
  instance_count     = var.dc_1_qpid_count
  instance_name      = var.dc_1_qpid_name
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_1_qpid_disk_size
  instance_type      = var.dc_1_qpid_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql",
    "apigee-qpid"
  ]
}
module "apigee-qpid-dc-2" {
  source             = "../modules/internal-instance"
  instance_zone      = var.dc_2_zone
  instance_count     = var.dc_2_qpid_count
  instance_name      = var.dc_2_qpid_name
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_2_qpid_disk_size
  instance_type      = var.dc_2_qpid_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql",
    "apigee-postgres"
  ]
}
module "apigee-qpid-dc-3" {
  source             = "../modules/internal-instance"
  instance_zone      = var.dc_3_zone
  instance_count     = var.dc_3_qpid_count
  instance_name      = var.dc_3_qpid_name
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_3_qpid_disk_size
  instance_type      = var.dc_3_qpid_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql",
    "apigee-postgres"
  ]
}

# Add an apigee-vm instance
module "apigee-pg-only" {
  source             = "../modules/internal-instance"
  instance_name      = var.pg_only_name
  instance_count     = var.pg_only_count
  instance_zone      = var.dc_1_zone
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.pg_only_disk_size
  instance_disk_type = "pd-ssd"
  instance_type      = var.pg_only_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql",
    "apigee-postgres"
  ]
}

# Add an apigee-vm instance
module "apigee-pg-pgmaster-dc-1" {
  source             = "../modules/internal-instance"
  instance_name      = var.dc_1_pgmaster_name
  instance_count     = var.dc_1_pgmaster_count
  instance_zone      = var.dc_1_zone
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_1_pgmaster_disk_size
  instance_disk_type = "pd-ssd"
  instance_type      = var.dc_1_pgmaster_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql",
    "apigee-postgres"
  ]
}
module "apigee-pg-pgmaster-dc-2" {
  source             = "../modules/internal-instance"
  instance_name      = var.dc_2_pgmaster_name
  instance_count     = var.dc_2_pgmaster_count
  instance_zone      = var.dc_2_zone
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_2_pgmaster_disk_size
  instance_disk_type = "pd-ssd"
  instance_type      = var.dc_2_pgmaster_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql",
    "apigee-postgres"
  ]
}


# Add an apigee-vm instance
module "apigee-pg-pgstandby-dc-1" {
  source             = "../modules/internal-instance"
  instance_name      = var.dc_1_pgstandby_name
  instance_count     = var.dc_1_pgstandby_count
  instance_zone      = var.dc_1_zone
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_1_pgstandby_disk_size
  instance_disk_type = "pd-ssd"
  instance_type      = var.dc_1_pgstandby_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql",
    "apigee-postgres"
  ]
}
module "apigee-pg-pgstandby-dc-2" {
  source             = "../modules/internal-instance"
  instance_name      = var.dc_2_pgstandby_name
  instance_count     = var.dc_2_pgstandby_count
  instance_zone      = var.dc_2_zone
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dc_2_pgstandby_disk_size
  instance_disk_type = "pd-ssd"
  instance_type      = var.dc_2_pgstandby_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql",
    "apigee-postgres"
  ]
}

# Add an apigee-vm instance
module "apigee-dp" {
  source             = "../modules/internal-instance"
  instance_name      = var.dev_portal_name
  instance_count     = var.dev_portal_count
  instance_zone      = var.dc_1_zone
  instance_network   = google_compute_network.apigeenet.self_link
  instance_disk_size = var.dev_portal_disk_size
  instance_type      = var.dev_portal_instance_type
  instance_tags = [
    "apigeenet-allow-ssh",
    "apigeenet-allow-icmp",
    "apigeenet-allow-mgmt-ui",
    "apigeenet-allow-local",
    "postgresql",
    "apigee-dev-portal"
  ]
}

