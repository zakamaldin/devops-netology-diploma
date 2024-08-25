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

variable "vms_ssh_root_key" {
  type = string
  description = "Default ssh pub key, that will be store on remote machine in authorized_keys"
}

variable "diploma_state_sa_name" {
  type        = string
  default     = "zakamaldin-diploma-state-sa"
  description = "ServicaAccount for managing state of diploma project"
}

variable "diploma_state_ydb_name" {
  type        = string
  default     = "zakamaldin-diploma-state-ydb"
  description = "Serverless YDB name for tfstate_lock of diploma project"
}

variable "diploma_state_s3_name" {
  type        = string
  default     = "zakamaldin-diploma-state-storage"
  description = "Storage name for tfstate_lock of diploma project"
}

variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
