terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  # credentials = file("<NAME>.json")

  project = var.project
  region  = var.region
  zone    = var.zone
}

# TODO - this is automatically added to Firewalls and then fails to delete the VPC network
# TODO - include Firewall rule and add VPC network to firewall rule or force delete the VPC network
resource "google_compute_network" "vpc_network" {
  name = "${var.deployment_name}-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "${var.deployment_name}-vm"
  machine_type = var.vm_machine_type
  tags         = [ "datashare" ]
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/gcp-financial-services-public/global/images/${var.vm_image_version}"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  metadata = {
    instanceName = "${var.deployment_name}-vm"
    useRuntimeConfigWaiter =  true
    waiterConfigName = var.config_name
    deployApiToGke = var.deploy_api_to_cloudrun_gke
    #sourceImage: https://www.googleapis.com/compute/v1/projects/gcp-financial-services-public/global/images/{{ imageNames[selectedImageIndex] }}
    gceServiceAccount = var.gcp_service_account
    ingestionBucketName = "${var.project}${var.ingestion_storage_bucket_suffix}"

  }

   metadata_startup_script = "echo hi > /test.txt"
}

