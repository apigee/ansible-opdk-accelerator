resource "google_compute_instance" "vm_instance" {
  count        = "${var.instance_count}"
  name         = "${var.instance_name}-${count.index + 1}"
  zone         = "${var.instance_zone}"
  machine_type = "${var.instance_type}"
  tags         = "${var.instance_tags}"
  labels = {
    g-on-g-notify-ignore = true
  }

  boot_disk {
    initialize_params {
      image = "${var.instance_image}"
      size  = "${var.instance_disk_size}"
    }
  }

  network_interface {
    network = "${var.instance_network}"
  }
}

data "google_compute_image" "apigeenet-ms-compute-image" {
  name    = "centos-7-v20190423"
  project = "centos-cloud"
}
