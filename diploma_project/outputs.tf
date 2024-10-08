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

output "setup_jenkins_command" {
  value = "ansible-playbook jenkins/setup_jenkins.yml -i jenkins/inventory/jenkins/hosts.yml"
}