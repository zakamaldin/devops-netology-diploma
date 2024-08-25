resource "yandex_vpc_network" "vpc" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "vpc_subnet_public_a" {
  name           = var.vpc_subnet_public_name_zone_a
  zone           = var.zone_a
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.vpc_subnet_public_cidr_zone_a
}

resource "yandex_vpc_subnet" "vpc_subnet_public_b" {
  name           = var.vpc_subnet_public_name_zone_b
  zone           = var.zone_b
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.vpc_subnet_public_cidr_zone_b
}

resource "yandex_vpc_subnet" "vpc_subnet_public_d" {
  name           = var.vpc_subnet_public_name_zone_d
  zone           = var.zone_d
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.vpc_subnet_public_cidr_zone_d
}