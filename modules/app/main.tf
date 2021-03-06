resource "google_compute_instance" "app" {
  name         = "ruby-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["ruby-app"]

  # определение загрузочного диска 
  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.user_public_key_path)}"
  }

  # определение сетевого интерфейса 
  network_interface {
    # сеть, к которой присоединить данный интерфейс 
    network = "default"

    # использовать ephemeral IP для доступа из Интернет 
    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  connection {
    type  = "ssh"
    user  = "appuser"
    agent = false

    # путь до приватного ключа
    private_key = "${file(var.user_privat_key_path)}"
  }

}

resource "google_compute_address" "app_ip" { 
  name = "ruby-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило 
  network = "default"

  # Какой доступ разрешить 
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с перечисленными тэгами 
  target_tags = ["ruby-app"]
}
