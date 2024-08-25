resource "kubernetes_namespace" "ingress" {
  depends_on = [ null_resource.get_kube_config ]
  metadata {
    name = var.ingress_metadata.namespace
  }
}

resource "helm_release" "ingress-nginx" {
  depends_on = [ kubernetes_namespace.ingress ]
  name       = var.ingress_metadata.name
  namespace  = var.ingress_metadata.namespace
  version    = var.ingress_metadata.version
  repository = var.ingress_metadata.repository
  chart      = var.ingress_metadata.chart
}
