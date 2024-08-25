output "update_etc_hosts" {
  value = "echo '<ingress LoadBalancer> monitoring.zakamaldin.test' > /etc/hosts"
}

output "prometheus_url" {
  value = "http://monitoring.zakamaldin.test/prometheus/targets?search=c"
}

output "alertmanager_url" {
  value = "http://monitoring.zakamaldin.test/alertmanager/#/alerts"
}

output "grafana_url" {
  value = "http://monitoring.zakamaldin.test/grafana/login"
}

output "registry_iam_token" {
  value = data.local_file.iam_token.content
}

output "registry_id" {
  value = yandex_container_registry.zakamaldin-diploma-registry.id
}