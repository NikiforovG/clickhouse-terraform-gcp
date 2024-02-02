variable "project_id" {
  description = "The ID of the GCP project where the instance will be created."
  default     = "test-project"
}


variable "region" {
  description = "The GCP region where the resources will be provisioned."
  default     = "europe-west1"
}


variable "zone" {
  description = "The GCP zone within the specified region where the instance will be created."
  default     = "europe-west1-b"
}


variable "device_name" {
  description = "Name of CH disk."
  default     = "clickhousedata"
}

variable "ssh_keys" {
  description = "SSH public keys for user access to the instance. Each key is associated with a user name."
  default     = [
    {
      user = "user",
      key  = "public ssh key",
    }
  ]
}
