provider "google" {
  //  credentials = "${file("~/.apigee-secure/friasc-lab-f2035754a9ae.json")}"
  credentials = "${file("~/.apigee-secure/edge-ops-lab-e7a48eec6f40.json")}"

  //  project     = "friasc-lab"
  project = "edge-ops-lab"
  region  = "us-east1"
}
