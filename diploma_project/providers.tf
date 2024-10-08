terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
  required_version = ">=0.13"

  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket = "zakamaldin-diploma-state-storage"
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gpgpkko4enmuce4gmv/etn1vpf1tmnj1fg9idg5"
    dynamodb_table = "zakamaldin-diploma-tflock"
    region = "ru-central1"
    key = "terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true
  }
 }

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone_a
}

provider "helm" {
  kubernetes {
    config_path = pathexpand(var.kube_config)
  }
}

provider "kubernetes" {
  config_path = pathexpand(var.kube_config)
}

provider "kubectl" {
  config_path = pathexpand(var.kube_config)
}