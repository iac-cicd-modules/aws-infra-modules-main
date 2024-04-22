resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "45.24.0"


  values = [
    file("${path.module}/kube-prometheus.yml")
  ]

   set {
     name = "grafana.grafanaSpec.nodeSelector.name"
     value = var.node_selector
   }

  set {
     name = "grafana.nodeSelector.name"
     value = var.node_selector
   }

  set {
     name = "kube-state-metrics.nodeSelector.name"
     value = var.node_selector
   }
  
  set {
    name = "alertmanager.alertmanagerSpec.nodeSelector.name"
    value = var.node_selector
  }

  set {
    name = "prometheus-node-exporter.nodeSelector.name"
    value = var.node_selector
  }
  
  set {
     name = "prometheusOperator.nodeSelector.name"
     value = var.node_selector
   }


   set {
     name = "prometheus.prometheusSpec.nodeSelector.name"
     value = var.node_selector
   }


  depends_on = [null_resource.cluster_ca_cert]

}

resource "helm_release" "loki_stack_grafana" {
  name       = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.storageClassName"
    value = "gp2"
  }

    set {
    name  = "persistence.size"
    value = "20Gi"
  }

  set {
    name = "loki.nodeSelector.name"
    value = var.node_selector
  }

    set {
    name = "promtail.nodeSelector.name"
    value = var.node_selector
  }

  depends_on = [null_resource.cluster_ca_cert]

}