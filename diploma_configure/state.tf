resource "yandex_iam_service_account" "admin_sa" {
  folder_id = var.folder_id
  name      = "admin"
}

resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = var.folder_id
  role      = "admin"
  member    = "serviceAccount:${yandex_iam_service_account.admin_sa.id}"
}

resource "yandex_iam_service_account" "diploma_state_sa" {
  folder_id = var.folder_id
  name      = var.diploma_state_sa_name
}

resource "yandex_ydb_database_serverless" "diploma_state_ydb" {
  name      = var.diploma_state_ydb_name
  folder_id =  var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "diploma_state_ydb_editor" {
  folder_id = var.folder_id
  role      = "ydb.editor"
  member    = "serviceAccount:${yandex_iam_service_account.diploma_state_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "diploma_state_s3_editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.diploma_state_sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "admin_sa_static_key" {
  service_account_id = yandex_iam_service_account.admin_sa.id
}
resource "yandex_storage_bucket" "diploma_state_s3" {
  access_key = yandex_iam_service_account_static_access_key.admin_sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.admin_sa_static_key.secret_key
  bucket = var.diploma_state_s3_name
  grant {
    id          = yandex_iam_service_account.diploma_state_sa.id
    type        = "CanonicalUser"
    permissions = ["READ", "WRITE"]
  }
}

resource "yandex_iam_service_account_static_access_key" "diploma_state_sa_static_key" {
  service_account_id = yandex_iam_service_account.diploma_state_sa.id
}

resource "local_file" "init_s3_backend_command" {
    depends_on = [ yandex_iam_service_account_static_access_key.diploma_state_sa_static_key ]
    content = templatefile("${path.module}/init_s3_backend_command.tftpl",
        { 
            access_key = nonsensitive(yandex_iam_service_account_static_access_key.diploma_state_sa_static_key.access_key)
            secret_key = nonsensitive(yandex_iam_service_account_static_access_key.diploma_state_sa_static_key.secret_key)
        }
    )

  filename = "${abspath(path.module)}/init_s3_backend_command.sh"
}
