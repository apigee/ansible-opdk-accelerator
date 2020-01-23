provider "google" {
  credentials = "${file(var.credentials_file)}"
  project     = "${var.gcp_project_name}"
  region      = "${var.dc_1_gcp_region}"
}
