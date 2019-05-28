provider "google" {
  credentials = "${file("~/.apigee-secure/edge-ops-lab-e7a48eec6f40.json")}"
  project     = "edge-ops-lab"
  region = "us-central1"
}
