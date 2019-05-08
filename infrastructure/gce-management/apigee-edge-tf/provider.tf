provider "google" {
  credentials = "${file("~/.apigee-secure/friasc-lab-f2035754a9ae.json")}"
  project     = "friasc-lab"
  region      = "us-east1"
}
