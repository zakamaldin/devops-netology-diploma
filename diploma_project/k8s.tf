resource "yandex_iam_service_account" "netology-k8s-resource-sa" {
  folder_id = var.folder_id
  name      = var.k8s_cluster_metadata.resource_sa_name
}

resource "yandex_iam_service_account" "netology-k8s-hosts-sa" {
  folder_id = var.folder_id
  name      = var.k8s_cluster_metadata.hosts_sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "netology-k8s-resource-sa-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.netology-k8s-resource-sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "netology-k8s-hosts-sa-puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.netology-k8s-hosts-sa.id}"
}

resource "yandex_kubernetes_cluster" "regional_k8s_cluster" {
  name        = var.k8s_cluster_metadata.name
  network_id = "${yandex_vpc_network.vpc.id}"

  master {
    regional {
      region = var.k8s_cluster_metadata.region

      location {
        zone      = "${yandex_vpc_subnet.vpc_subnet_public_a.zone}"
        subnet_id = "${yandex_vpc_subnet.vpc_subnet_public_a.id}"
      }

      location {
        zone      = "${yandex_vpc_subnet.vpc_subnet_public_b.zone}"
        subnet_id = "${yandex_vpc_subnet.vpc_subnet_public_b.id}"
      }

      location {
        zone      = "${yandex_vpc_subnet.vpc_subnet_public_d.zone}"
        subnet_id = "${yandex_vpc_subnet.vpc_subnet_public_d.id}"
      }
    }

    version   = var.k8s_cluster_metadata.version
    public_ip = var.k8s_cluster_metadata.public_ip

    maintenance_policy {
      auto_upgrade = var.k8s_cluster_metadata.auto_upgrade
    }
  }

  service_account_id      = "${yandex_iam_service_account.netology-k8s-resource-sa.id}"
  node_service_account_id = "${yandex_iam_service_account.netology-k8s-hosts-sa.id}"

  release_channel = var.k8s_cluster_metadata.release_channel
  depends_on = [
    yandex_resourcemanager_folder_iam_member.netology-k8s-resource-sa-editor,
    yandex_resourcemanager_folder_iam_member.netology-k8s-hosts-sa-puller
  ]
}

resource "yandex_kubernetes_node_group" "regional_k8s_cluster_node_group" {
  cluster_id  = "${yandex_kubernetes_cluster.regional_k8s_cluster.id}"
  name        = var.k8s_cluster_node_group_metadata.name
  version     = var.k8s_cluster_node_group_metadata.version

  instance_template {
    platform_id = var.k8s_cluster_node_group_metadata.platform_id
    
    network_interface {
      nat    = var.k8s_cluster_node_group_metadata.nat
      subnet_ids         = ["${yandex_vpc_subnet.vpc_subnet_public_a.id}"]
    }
    resources {
      memory = var.k8s_cluster_node_group_metadata.memory
      cores  = var.k8s_cluster_node_group_metadata.cores
    }

    boot_disk {
      type = var.k8s_cluster_node_group_metadata.disk_type
      size = var.k8s_cluster_node_group_metadata.disk_size
    }

    scheduling_policy {
      preemptible = var.k8s_cluster_node_group_metadata.preemptible
    }

    container_runtime {
      type = var.k8s_cluster_node_group_metadata.runtime_type
    }
  }

  scale_policy {
    auto_scale {
      min     = var.k8s_cluster_node_group_metadata.auto_scale_min
      max     = var.k8s_cluster_node_group_metadata.auto_scale_max
      initial = var.k8s_cluster_node_group_metadata.auto_scale_initial
    }
  }
  
  allocation_policy {
    location {
        zone      = "${yandex_vpc_subnet.vpc_subnet_public_a.zone}"
      }
  }
}

resource "null_resource" "get_kube_config" {
  depends_on = [ yandex_kubernetes_cluster.regional_k8s_cluster, yandex_kubernetes_node_group.regional_k8s_cluster_node_group ]
  provisioner "local-exec" {
    command = "yc config profile activate default && yc managed-kubernetes cluster get-credentials k8s-netology-cluster --external --force"
  }
}