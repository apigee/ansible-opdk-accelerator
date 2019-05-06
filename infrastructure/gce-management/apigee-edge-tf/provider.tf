provider "google" {
  credentials = "${file("~/.apigee-secure/edge-ops-lab-e7a48eec6f40.json")}"
  project = "edge-labs-ops"
  region = "us-central1"
}
