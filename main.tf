terraform {
  # Версия terraform 
  required_version = "0.11.11"

  backend "gcs" {
    bucket = "storage-terraform-background-bucket"
  }
}

provider "google" {
  # Версия провайдера version = "2.0.0"
  # ID проекта
  project = "${var.project}"

  region = "${var.region}"
}

module "app" {
  source          = "./modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  project         = "${var.project}"
  user_public_key_path = "${var.public_key_path}"
  user_privat_key_path = "${var.user_privat_key_path}"
}

module "db" {
  source          = "./modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
  project         = "${var.project}"
  user_public_key_path = "${var.public_key_path}"
  user_privat_key_path = "${var.user_privat_key_path}"
}

module "vpc" {
  source = "./modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
