output "apigeenet_self_link" {
  value = "${data.google_compute_network.apigeenet.self_link}"
}

output "bastion_ip" {
  value = "${module.apigee-bastion-vm.network_ip}"
}
