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

### k8s vars
variable "k8s_cluster_metadata" {
  type = object({
    name             = string
    resource_sa_name = string
    hosts_sa_name    = string
    version          = string
    public_ip        = bool
    auto_upgrade     = bool
    release_channel  = string
    region           = string
  })

  default = {
    name             = "k8s-netology-cluster"
    resource_sa_name = "netology-k8s-resource-sa"
    hosts_sa_name    = "netology-k8s-hosts-sa"
    version          = "1.27"
    public_ip        = true
    auto_upgrade     = false
    release_channel  = "STABLE"
    region           = "ru-central1"
  }
  description = "Default resources of k8s cluster"
}


variable "k8s_cluster_node_group_metadata" {
  type = object({
    name               = string
    version            = string
    platform_id        = string
    nat                = bool
    memory             = number
    cores              = number
    disk_type          = string
    disk_size          = number
    preemptible        = bool
    runtime_type       = string
    auto_scale_min     = number
    auto_scale_max     = number
    auto_scale_initial = number
  })

  default = {
      name               = "netology-k8s-node-group"
      version            = "1.27"
      platform_id        = "standard-v2"
      nat                = true
      memory             = 2
      cores              = 2
      disk_type          = "network-hdd"
      disk_size          = 64
      preemptible        = true
      runtime_type       = "containerd"
      auto_scale_min     = 3
      auto_scale_max     = 6
      auto_scale_initial = 3
  }
  description = "Default resources of k8s node group"
}

variable "kube_config" {
  type    = string
  default = "~/.kube/config"
  description = "Path for kubeconfig"
}

### monitoring vars
variable "monitoring_metadata" {
  type = object({
    name       = string
    namespace  = string
    version    = string
    repository = string
    chart      = string
  })

  default = {
    name       = "kube-prometheus-stack"
    namespace  = "monitoring"
    version    = "61.9.0"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart      = "kube-prometheus-stack"
  }
  description = "Default resources of kube-prometheus-stack chart"
}

### ingress vars
variable "ingress_metadata" {
  type = object({
    name       = string
    namespace  = string
    version    = string
    repository = string
    chart      = string
  })

  default = {
    name       = "ingress-nginx"
    namespace  = "ingress"
    version    = "4.1.1"
    repository = "https://kubernetes.github.io/ingress-nginx"
    chart      = "ingress-nginx"
  }
  description = "Default resources of k8s ingress gateway controller chart"
}

### regisrty vars
variable "registry_name" {
  type        = string
  default     = "zakamaldin-diploma-registry"
  description = "Docker registry name"
}

variable "registry_sa_name" {
  type        = string
  default     = "zakamaldin-diploma-registry-sa"
  description = "Docker registry sa name"
}