output "dynamodb_endpoint" {
  value = yandex_ydb_database_serverless.diploma_state_ydb.document_api_endpoint
}

output "init_s3_backend_command" {
  value = "Use command from init_s3_backend_command.sh to move state in s3 bucket"
}