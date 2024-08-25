###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

### ssh var

variable "vms_ssh_root_key" {
  type = string
  description = "Default ssh pub key, that will be store on remote machine in authorized_keys"
}

### state vars
variable "diploma_ydb_name" {
  type        = string
  default     = "zakamaldin-diploma-ydb"
  description = "Serverless YDB name for tfstate_lock diploma project"
}

### network vars
variable "vpc_name" {
  type        = string
  default     = "zakamaldin-diploma-vpc"
  description = "VPC network & subnet name"
}
variable "zone_a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_subnet_public_cidr_zone_a" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_subnet_public_cidr_zone_b" {
  type        = list(string)
  default     = ["192.168.11.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_subnet_public_cidr_zone_d" {
  type        = list(string)
  default     = ["192.168.12.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "vpc_subnet_public_name_zone_a" {
  type        = string
  default     = "public-a"
  description = "VPC network & subnet name"
}

variable "vpc_subnet_public_name_zone_b" {
  type        = string
  default     = "public-b"
  description = "VPC network & subnet name"
}

variable "vpc_subnet_public_name_zone_d" {
  type        = string
  default     = "public-d"
  description = "VPC network & subnet name"
}