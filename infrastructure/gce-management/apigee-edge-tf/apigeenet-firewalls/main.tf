variable "firewall_name" {}
variable "firewall_network" {}
variable "firewall_source_ranges" {}
variable "firewall_protocol" {}
variable "firewall_ports" {
  default = []
}

# Add a firewall rule to allow HTTP, SSH, and RDP traffic on apigeenet
resource "google_compute_firewall" "apigeenet-allow-tcp-icmp" {
  count = "${length(var.firewall_ports)}"
  name    = "${var.firewall_name}"
  network = "${var.firewall_network}"

  source_ranges = "${var.firewall_source_ranges}"

  allow {
    protocol = "${var.firewall_protocol}"
  }
}

resource "google_compute_firewall" "apigeenet-allow-tcp-icmp" {
  count = "%{ if length(var.firewall_ports) > 0 }1%{else}0%{endif}"
  name    = "${var.firewall_name}"
  network = "${var.firewall_network}"

  source_ranges = "${var.firewall_source_ranges}"

  allow {
    protocol = "${var.firewall_protocol}"

    %{ if ${var.firewall_ports} != [] ~}
    ports    = "${var.firewall_ports}"
    %{ endif ~}
  }
}

