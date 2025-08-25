module "k3s_cluster" {
  source = "./modules/k3s_cluster"

  template_name            = var.template_name
  network_name             = var.network_name
  ssh_authorized_key = file("~/.ssh/id_rsa.pub")
}