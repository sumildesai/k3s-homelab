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

variable "master_ip" {
  default = "192.168.50.100"
}

variable "gateway" {
  description = "Gateway IP address for the network"
  type        = string
  default     = "192.168.50.1"
}

variable "nameservers" {
  description = "List of DNS nameservers"
  type        = list(string)
  default     = ["192.168.50.1", "1.1.1.1"]
}

variable "worker_ips" {
  description = "List of IP addresses for worker nodes"
  type        = list(string)
  default     = ["192.168.50.101", "192.168.50.102", "192.168.50.103"]
}

variable "sr_id" {
  description = "Storage Repository ID for VM disks"
  type        = string
  default     = "1e72409b-a3ff-7455-4bba-362dbd19884d"
}

variable "template_name" {
  description = "Name of the Xen Orchestra template to use for VMs"
  type        = string
  default     = "Ubuntu 24.04 Cloud-Init (Hub)"
}

variable "network_name" {
  description = "Name of the Xen Orchestra network to attach VMs to"
  type        = string
  default     = "Pool-wide network associated with eth0"  
}