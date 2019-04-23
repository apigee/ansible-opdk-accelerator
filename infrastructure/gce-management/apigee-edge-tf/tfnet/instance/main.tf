variable "instance_name" {}
variable "instance_zone" {}
variable "instance_image" {
  default = "centos-7"
}
variable "instance_type" {
  default = "n1-standard-1"
}
variable "instance_subnetwork" {}
variable "instance_tags" {
  default = list()
}

resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}"
  zone         = "${var.instance_zone}"
  machine_type = "${var.instance_type}"
  tags         = "${var.instance_tags}"

  boot_disk {
    initialize_params {
      image = "${var.instance_image}"
    }
  }

  network_interface {
    subnetwork = "${var.instance_subnetwork}"

    access_config {
      # Allocate a one-to-one NAT IP to the instance
    }
  }
}
