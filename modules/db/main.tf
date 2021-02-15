resource "google_compute_instance" "db" {
  name         = "ruby-db"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["ruby-db"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.user_public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  target_tags = ["ruby-db"]
  source_tags = ["ruby-app"]
}
