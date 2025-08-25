terraform {
  required_providers {
    xenorchestra = {
      source  = "terra-farm/xenorchestra"
    #   version = "~> 0.6.0"
    }
  }
}

provider "xenorchestra" {
  url      = "ws://192.168.50.59"
  username = "admin"
  password = "Password"
  insecure = true # if using self-signed certs
}

data "xenorchestra_template" "ubuntu" {
  name_label = var.template_name
}

data "xenorchestra_network" "net" {
  name_label = var.network_name
}

