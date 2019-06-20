resource "google_compute_firewall" "apigeenet-allow-firewall-ports" {
  name    = "${var.firewall_name}"
  count   = "${length(var.firewall_ports) > 0 ? 1 : 0}"
  network = "${var.firewall_network}"

  source_ranges = "${var.firewall_source_ranges}"
  source_tags   = "${var.firewall_source_tags}"

  allow {
    protocol = "${var.firewall_protocol}"
    ports    = "${var.firewall_ports}"
  }
}
