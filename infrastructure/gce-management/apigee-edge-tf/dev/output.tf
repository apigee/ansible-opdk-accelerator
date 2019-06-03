output "apigeenet_self_link" {
  value = "${google_compute_network.apigeenet.self_link}"
}

//output "bastion_private_ip" {
//  value = "${module.apigee-bastion-vm.private_ip}"
//}
//
//output "bastion_public_ip" {
//  value = "${module.apigee-bastion-vm.public_ip}"
//}

