# Add a firewall rule to allow HTTP, SSH, and RDP traffic on apigeenet
resource "google_compute_firewall" "apigeenet-allow-firewall-protocol-only" {
  name    = "${var.firewall_name}"
  network = "${var.firewall_network}"

  source_ranges = "${var.firewall_source_ranges}"

  allow {
    protocol = "${var.firewall_protocol}"
  }
}
