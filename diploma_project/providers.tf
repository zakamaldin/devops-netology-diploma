terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"

  # backend "s3" {
  #   endpoint = "https://storage.yandexcloud.net"
  #   bucket = "zakamaldin-diploma-state-storage"
  #   dynamodb_endpoint = ""
  #   dynamodb_table = "zakamaldin-diploma-tflock"
  #   region = "ru-central1"
  #   key = "terraform.tfstate"
  #   skip_region_validation = true
  #   skip_credentials_validation = true
  #   skip_requesting_account_id  = true 
  #   skip_s3_checksum            = true
  # }
 }

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone_a
}