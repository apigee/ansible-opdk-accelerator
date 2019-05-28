variable "instance_name" {}
variable "instance_zone" {}

variable "instance_image" {
  default = "centos-7"
}

variable "instance_type" {
  default = "n1-standard-1"
}

variable "instance_network" {}

variable "instance_tags" {
  default = []
}

variable "instance_external_ip" {
  default = ""
}

resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}"
  zone         = "${var.instance_zone}"
  machine_type = "${var.instance_type}"
  tags         = "${var.instance_tags}"

  boot_disk {
    initialize_params {
      image = "${var.instance_image}"
      size  = 60
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
