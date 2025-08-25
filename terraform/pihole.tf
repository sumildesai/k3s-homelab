module "pihole" {
  source            = "./modules/pihole"

  template_name     = "Ubuntu 24.04 Cloud-Init (Hub)"
  network_name      = var.network_name

  vm_name           = "pihole"
  vm_cpus           = 1
  vm_memory_mb      = 512
  disk_size_gb      = 16
  sr_id             = var.sr_id

  ip_address        = "192.168.50.200"
  cidr_prefix       = 24
  gateway           = var.gateway
  nameservers       = var.nameservers

  web_password      = "Password"
  dns_upstream1     = "1.1.1.1"
  dns_upstream2     = "8.8.8.8"

  password           = "Password"
  ssh_authorized_key = file("~/.ssh/id_rsa.pub")
}
