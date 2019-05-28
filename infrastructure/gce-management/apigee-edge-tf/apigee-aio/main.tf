# Create the apigeenet network
data "google_compute_network" "apigeenet" {
  name = "default"
}

# Create the apigeenet router
resource "google_compute_router" "apigeenet-router" {
  name    = "apigeenet-router"
  network = "${data.google_compute_network.apigeenet.self_link}"
}

# Create the gateway nat for the apigeenet-subnet-router
resource "google_compute_router_nat" "apigeenet-subnet-nat" {
  name = "apigeenet-subnet-nat"

  //    router                             = "${var.router_name}"
  router                             = "${google_compute_router.apigeenet-router.name}"
  region                             = "${var.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# Add an apigee-vm instance
resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}"
  zone         = "${var.zone}"
  machine_type = "${var.machine_type}"
  tags         = "${var.instance_tags}"

  boot_disk {
    initialize_params {
      image = "${var.image_name}"
      size  = 60
    }
  }

  network_interface {
    network = "${data.google_compute_network.apigeenet.self_link}"

    //    access_config = {}
  }
}
