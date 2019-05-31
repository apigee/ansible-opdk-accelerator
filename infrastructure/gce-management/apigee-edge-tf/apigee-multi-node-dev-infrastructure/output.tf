output "apigeenet_self_link" {
  value = "${data.google_compute_network.apigeenet.self_link}"
}

output "bastion_private_ip" {
  value = "${module.apigee-bastion-vm.private_network_ip}"
}

output "bastion_public_ip" {
  value = "${module.apigee-bastion-vm.public_network_ip}"
}
