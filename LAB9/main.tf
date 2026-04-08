provider "null" {}

resource "null_resource" "openfaas_function" {

  provisioner "local-exec" {
    command = "echo 'Deploying OpenFaaS Function'"
  }

  provisioner "local-exec" {
    command = "faas-cli login -u admin --password-stdin"
  }

  provisioner "local-exec" {
    command = "faas-cli deploy -f hello-node.yml"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "destroy_function" {

  provisioner "local-exec" {
    when    = destroy
    command = "faas-cli remove hello-node"
  }
}