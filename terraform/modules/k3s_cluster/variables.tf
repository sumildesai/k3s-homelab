variable "template_name" { type = string }
variable "network_name"  { type = string }

variable "k3s_master_count" {
  type    = number
  default = 1
}
variable "k3s_worker_count" {
  type    = number
  default = 2
}
variable "k3s_master_name_prefix" {
  type    = string
  default = "k3s-master-"
}
variable "k3s_worker_name_prefix" {
  type    = string
  default = "k3s-worker-"
}

variable "sr_id" { 
  type    = string
  default = "1e72409b-a3ff-7455-4bba-362dbd19884d"
}
variable "username" {
  type        = string
  description = "Username to create on the VM"
  default     = "ubuntu"
}
variable "cidr_prefix" { 
  type    = number
  default = 24
}
variable "gateway" {
  type    = string 
  default = "192.168.50.1"
}
variable "nameservers"   { 
  type    = list(string)
  default = ["192.168.50.1", "1.1.1.1"]
}

variable "ssh_authorized_key" { type = string }

variable "master_names" { 
  type    = list(string)
  default = ["k3s-master-01"] 
}
variable "master_ips" {
  type    = list(string)
  default = ["192.168.50.100"]
}
variable "master_vm_cpus"       { 
  type    = number
  default = 2
}
variable "master_vm_memory" { 
  type    = number
  default = 2048 * 1024 * 1024 # 2GB
}
variable "master_disk_size" { 
  type    = number
  default = 30 * 1024 * 1024 * 1024 # 30GB 
}

variable "worker_hostnames" {
  type    = list(string)
  default = ["k3s-worker-01", "k3s-worker-02"]
}
variable "worker_ips" {
  type    = list(string)
  default = ["192.168.50.101", "192.168.50.102"]
}
variable "worker_vm_cpus" {
  type    = number
  default = 8
}
variable "worker_vm_memory" {
  type    = number
  default = 8192 * 1024 * 1024 # 8GB
}
variable "worker_disk_size" {
  type    = number
  default = 100 * 1024 * 1024 * 1024 # 100GB
}


