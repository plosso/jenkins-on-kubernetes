
resource "helm_release" "jenkins_controller" {
  name       = "devops-jenkins"
  repository = "https://charts.jenkins.io/"
  chart      = "jenkins"
  namespace = "devops-tools"

  values = [
    "${file("values.yaml")}"
  ]

}