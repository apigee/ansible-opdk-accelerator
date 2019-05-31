resource "google_compute_region_instance_group_manager" "apigeenet-ms-group-instance" {
  name                      = "${var.group_manager_name}"
  base_instance_name        = "${google_compute_instance_template.apigeenet-base-instance-template.name}"
  region                    = "${var.instance_region}"
  instance_template         = "${google_compute_instance_template.apigeenet-base-instance-template.self_link}"
  distribution_policy_zones = ["${var.instance_distribution_policy_zones}"]
  target_size               = "${var.instance_count}"

  named_port {
    name = "${var.group_manager_port_name}"
    port = "${var.group_manager_port}"
  }
}

resource "google_compute_instance_template" "apigeenet-base-instance-template" {
  name           = "${var.instance_name}"
  machine_type   = "${var.machine_type}"
  can_ip_forward = false
  tags           = "${var.instance_tags}"

  network_interface {
    network = "${var.instance_network}"

    access_config = {}
  }

  labels {
    g-on-g-notify-ignore = ""
  }

  disk {
    auto_delete = true
    boot        = true

    source_image = "${data.google_compute_image.apigeenet-base-system-image.self_link}"
    disk_size_gb = "${var.instance_size}"
    disk_type    = "pd-ssd"
  }
}

data "google_compute_image" "apigeenet-base-system-image" {
  name    = "centos-7-v20190423"
  project = "centos-cloud"
}
