provider "google" {
  project = "playground-s-11-68a6505a"
  region  = "europe-west1-b"
  zone    = "europe-west1-b"
}

resource "google_compute_network" "vpc_network" {
  name = "yoann-vpc-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_instance" "vm_instance" {
  name         = "yoann-terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.id
    access_config {
    }
  }
}

resource "google_storage_bucket" "cloud_bucket" {
  name     = "yoann-terraform-file-bucket"
  location = "europe-west1"
  force_destroy = false

  uniform_bucket_level_access = true
}