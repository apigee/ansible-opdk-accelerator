output "apigeenet_self_link" {
  value = "${google_compute_network.apigeenet.self_link}"
}

//output "instance_group" {
//  value = "${google_compute_region_instance_group_manager.apigeenet-ms-group-instance.instance_group}"
//}
//
//output "bastion_private_ip" {
//  value = "${module.apigee-bastion-vm.private_network_ip}"
//}
//
//output "bastion_public_ip" {
//  value = "${module.apigee-bastion-vm.public_network_ip}"
//}
