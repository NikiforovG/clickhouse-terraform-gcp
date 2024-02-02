resource "google_compute_address" "static_ip" {
  name = "ip-clickhouse"
  region = var.region
}


resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"
  target_tags = ["http-server"]

  allow {
    protocol = "tcp"
    ports    = ["80","8123"]
  }

  source_ranges = ["0.0.0.0/0"]  # Adjust this to limit access
}


resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]  # Adjust this to limit access
}