resource "google_compute_disk" "disk_clickhouse" {
  name  = "disk-clickhouse"
  type  = "pd-ssd"
  zone  = var.zone
  size  = 10  # Size in GB
}


resource "google_compute_attached_disk" "default" {
  disk = google_compute_disk.disk_clickhouse.self_link
  device_name = var.device_name
  instance = google_compute_instance.instance_clickhouse.self_link
  zone = var.zone
}


resource "google_compute_instance" "instance_clickhouse" {
  name         = "instance-clickhouse"
  machine_type = "e2-medium"
  zone         = var.zone
  tags         = ["http-server", "https-server"]

  boot_disk {
    auto_delete = true
    device_name = "instance-clickhouse"

    initialize_params {
      image = "debian-cloud/debian-12"
    }

    mode = "READ_WRITE"
  }

  network_interface {
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
    queue_count = 0
    stack_type  = "IPV4_ONLY"
    network="default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  # YOU NEED THIS TO PREVENT DISK ATTACHMENT LOOP
  lifecycle {
    ignore_changes = [attached_disk]
  }

  metadata = {
    ssh-keys = join("\n", [for user_key in var.ssh_keys : "${user_key.user}:${user_key.key}"]),
    startup-script = templatefile("files/init.sh",
      {
        "device_name": var.device_name
      }
    )
  }
}
