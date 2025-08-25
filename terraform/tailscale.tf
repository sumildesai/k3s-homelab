module "tailscale" {
  source            = "./modules/vm_template"

  template_name     = "Ubuntu 24.04 Cloud-Init (Hub)"
  network_name      = var.network_name

  vm_name           = "tailscale"
  vm_cpus           = 1
  vm_memory_mb      = 1024
  disk_size_gb      = 8
  sr_id             = var.sr_id

  ip_address        = "192.168.50.201"
  cidr_prefix       = 24
  gateway           = var.gateway
  nameservers       = var.nameservers

  password           = "Password"
  ssh_authorized_key = file("~/.ssh/id_rsa.pub")
}
