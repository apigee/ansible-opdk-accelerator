resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}"
  zone         = "${var.instance_zone}"
  machine_type = "${var.instance_type}"
  tags         = "${var.instance_tags}"
  labels       = {}

  boot_disk {
    initialize_params {
      image = "${var.instance_image}"
      size  = "${var.instance_disk_size}"
    }
  }

  network_interface {
    network = "${var.instance_network}"
    access_config {}
  }

  service_account {
    email  = "${var.service_account_email}"
    scopes = "${var.instance_scopes}"
  }
}
