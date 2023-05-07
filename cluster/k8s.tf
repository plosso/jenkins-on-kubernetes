resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = "devops-tools"
  }
}

resource "kubernetes_secret" "jenkins_admin_password" {

  depends_on = [resource.kubernetes_namespace.jenkins]

  metadata {
    name = "jenkins-auth"
    namespace = "${kubernetes_namespace.jenkins.metadata[0].name}"
  }

  data = {
    username = "admin"
    password = "changeme"
  }

}

resource "kubernetes_service_account" "jenkins_admin_user" {

  depends_on = [resource.kubernetes_secret.jenkins_admin_password]

  metadata {
    name = "jenkins"
    namespace = "devops-tools"
  }
  secret {
    name = "${kubernetes_secret.jenkins_admin_password.metadata[0].name}"
  }
}
