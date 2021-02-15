variable project {
  description = "Project ID"
}

variable region {
  description = "Region"

  # Значение по умолчанию 
  default = "europe-west3"
}

variable zone {
  description = "Zone"
  default = "europe-west3-a"
  
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable user_public_key_path {
  description = "User Path to the public key used for ssh access"
}

variable user_privat_key_path {
  description = "User Path to the privat key"
}

variable app_disk_image {
  description = "App Disk image"
  default = "rubyapp-base"
}

variable db_disk_image {
  description = "DB Disk image"
  default = "db-base"
}
