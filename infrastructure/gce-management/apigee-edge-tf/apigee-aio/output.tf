output "apigeenet_self_link" {
  value = "${data.google_compute_network.apigeenet.self_link}"
}

//
//output "ms_global_address" {
//  value = "${google_compute_global_address.apigeenet-ms-global-address.address}"
//}
//
//output "apigeenet_ms_backend_service_self_link" {
//  value = "${google_compute_backend_service.apigeenet-ms-ui-backend-service.self_link}"
//}

