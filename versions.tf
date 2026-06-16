terraform {
  required_version = ">= 1.5"

  required_providers {
    airtelcloud = {
      source  = "Airtel-Cloud-Platform/file-storage/airtelcloud"
      version = ">= 1.0.0"
    }
  }
}
