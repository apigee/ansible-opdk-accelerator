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

variable "instance_scopes" {
  default = []
}

variable "service_account_email" {
  default = ""
}

variable "instance_disk_size" {
  default = 100
}

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

    access_config = {
      // Ephermeral IP
    }
  }

  service_account {
    email  = "${var.service_account_email}"
    scopes = "${var.instance_scopes}"
  }
}

output "network_ip" {
  value = "${google_compute_instance.vm_instance.network_interface.0.network_ip}"
}
