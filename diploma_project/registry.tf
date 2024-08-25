resource "yandex_container_registry" "zakamaldin-diploma-registry" {
  name      = var.registry_name
  folder_id = var.folder_id
}

resource "yandex_iam_service_account" "zakamaldin-diploma-registry-sa" {
  folder_id = var.folder_id
  name      = var.registry_sa_name
}

resource "yandex_container_registry_iam_binding" "zakamaldin-diploma-registry-sa-puller" {
  registry_id = yandex_container_registry.zakamaldin-diploma-registry.id
  role        = "container-registry.images.puller"
  members     = ["serviceAccount:${yandex_iam_service_account.zakamaldin-diploma-registry-sa.id}"]
}

resource "yandex_container_registry_iam_binding" "zakamaldin-diploma-registry-sa-pusher" {
  registry_id = yandex_container_registry.zakamaldin-diploma-registry.id
  role        = "container-registry.images.pusher"
  members     = ["serviceAccount:${yandex_iam_service_account.zakamaldin-diploma-registry-sa.id}"]
}

resource "null_resource" "get_iam_token" {
  depends_on = [yandex_container_registry.zakamaldin-diploma-registry, yandex_container_registry_iam_binding.zakamaldin-diploma-registry-sa-pusher ]
  provisioner "local-exec" {
    command = "/bin/bash get_iam_token.sh"
  }
}

data "local_file" "iam_token" {
  depends_on = [ null_resource.get_iam_token ]
  filename = "${path.module}/registry_token.txt"
}