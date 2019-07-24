provider "google" {
  credentials = "${file(var.credentials_file)}"
  project     = "${var.gcp_project_name}"
  region      = "${var.region}"
}
