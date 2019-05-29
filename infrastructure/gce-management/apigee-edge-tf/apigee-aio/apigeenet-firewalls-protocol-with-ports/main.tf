variable "firewall_name" {}
variable "firewall_network" {}

variable "firewall_source_ranges" {
  type = "list"
}

variable "firewall_protocol" {}

variable "firewall_ports" {
  default = []
}

resource "google_compute_firewall" "apigeenet-allow-firewall-ports" {
  count   = "${length(var.firewall_ports) > 0 ? 1 : 0}"
  name    = "${var.firewall_name}"
  network = "${var.firewall_network}"

  source_ranges = "${var.firewall_source_ranges}"

  allow {
    protocol = "${var.firewall_protocol}"
    ports    = "${var.firewall_ports}"
  }
}
