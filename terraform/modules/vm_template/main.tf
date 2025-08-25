terraform {
  required_providers {
    xenorchestra = {
      source  = "terra-farm/xenorchestra"
    }
  }
}

data "xenorchestra_template" "ubuntu_gold" {
  name_label = var.template_name
}

data "xenorchestra_network" "net" {
  name_label = var.network_name
}

locals {
  hashed_password = sha512(var.password)

  user_data = templatefile("${path.module}/cloud-init/user-data.tpl", {
    hostname      = var.vm_name
    username      = var.username
    # password      = local.hashed_password
    ssh_key       = var.ssh_authorized_key
  })

  network_config = templatefile("${path.module}/cloud-init/network-config.tpl", {
    ip_address  = var.ip_address
    cidr_prefix = var.cidr_prefix
    gateway     = var.gateway
    nameservers = var.nameservers
  })
}

resource "xenorchestra_vm" "vm" {
  name_label   = var.vm_name
  template     = data.xenorchestra_template.ubuntu_gold.id

  cpus               = var.vm_cpus
  cpu_cap            = var.vm_cpus
  memory_max         = var.vm_memory_mb * 1024 * 1024

  disk {
    sr_id      = var.sr_id
    name_label = "${var.vm_name}-disk0"
    size       = var.disk_size_gb * 1024 * 1024 * 1024
  }

  network {
    network_id = data.xenorchestra_network.net.id
  }

  cloud_config         = local.user_data
  cloud_network_config = local.network_config

  auto_poweron = true
}

output "vm_id" {
  value = xenorchestra_vm.vm.id
}

output "ip_address" {
  value = var.ip_address
}
