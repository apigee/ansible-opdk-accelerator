output "apigeenet_self_link" {
  value = "${data.google_compute_network.apigeenet.self_link}"
}

output "bastion_ip" {
  value = "${google_compute_instance.bastion_instance.network_interface.0.network_ip}"
}
