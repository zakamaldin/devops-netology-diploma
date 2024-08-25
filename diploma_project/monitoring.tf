resource "kubernetes_namespace" "monitoring" {
  depends_on = [ null_resource.get_kube_config ]
  metadata {
    name = var.monitoring_metadata.namespace
  }
}
resource "helm_release" "kube-prometheus" {
  depends_on = [ kubernetes_namespace.monitoring ]
  name       = var.monitoring_metadata.name
  namespace  = var.monitoring_metadata.namespace
  version    = var.monitoring_metadata.version
  repository = var.monitoring_metadata.repository
  chart      = var.monitoring_metadata.chart
  values = [
    "${file("${path.module}/monitoring/grafana_values.yaml")}"
  ]
}