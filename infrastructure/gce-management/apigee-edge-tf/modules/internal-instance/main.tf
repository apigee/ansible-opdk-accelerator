resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}"
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

  //  disk {
  //    auto_delete = true
  //    boot        = true
  //
  //    source_image = "${data.google_compute_image.apigeenet-ms-compute-image.self_link}"
  //    disk_size_gb = 60
  //    disk_type    = "pd-ssd"
  //  }

  network_interface {
    network = "${var.instance_network}"
  }
}

data "google_compute_image" "apigeenet-ms-compute-image" {
  name    = "centos-7-v20190423"
  project = "centos-cloud"
}
