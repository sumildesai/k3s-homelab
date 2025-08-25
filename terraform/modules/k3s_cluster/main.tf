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

resource "xenorchestra_vm" "k3s_master" {
  count        = var.k3s_master_count
  name_label   = "${var.k3s_master_name_prefix}${format("%02d", count.index + 1)}"
  cpus         = var.master_vm_cpus
  memory_max   = var.master_vm_memory
  template     = data.xenorchestra_template.ubuntu.id # use the template data source
  auto_poweron = true

  disk {
    size       = var.master_disk_size
    sr_id      = var.sr_id # find via XO or API
    name_label = "Master root disk"
  }

  network {
    network_id = data.xenorchestra_network.net.id
  }

  cloud_config = templatefile("${path.module}/cloud-init/user-data.tpl", {
    hostname   = var.master_names[0]
    ssh_key    = var.ssh_authorized_key
  })

  cloud_network_config = templatefile("${path.module}/cloud-init/network-config.tpl", {
    ip_address  = var.master_ips[0]
    cidr_prefix = var.cidr_prefix
    gateway     = var.gateway
    nameservers = var.nameservers
  })
}


resource "xenorchestra_vm" "k3s_worker" {
  count      = var.k3s_worker_count
  name_label = "${var.k3s_worker_name_prefix}${format("%02d", count.index + 1)}"
  cpus       = var.worker_vm_cpus
  memory_max = var.worker_vm_memory
  template   = data.xenorchestra_template.ubuntu.id # use the template data source

  auto_poweron = true

  disk {
    size       = var.worker_disk_size
    sr_id      = var.sr_id # find via XO or API
    name_label = "Worker root disk"
  }

  network {
    network_id = data.xenorchestra_network.net.id
  }

  cloud_config    = templatefile("${path.module}/cloud-init/user-data.tpl", {
    hostname      = var.worker_hostnames[count.index]
    ssh_key       = var.ssh_authorized_key
  })    

  cloud_network_config = templatefile("${path.module}/cloud-init/network-config.tpl", {
    ip_address         = var.worker_ips[count.index]
    cidr_prefix        = var.cidr_prefix
    gateway            = var.gateway
    nameservers        = var.nameservers
  })
}
