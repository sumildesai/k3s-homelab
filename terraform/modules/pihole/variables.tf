variable "template_name" { type = string }
variable "network_name"  { type = string }

variable "vm_name"       { type = string }
variable "vm_cpus"       { type = number }
variable "vm_memory_mb"  { type = number }
variable "disk_size_gb"  { type = number }
variable "sr_id"         { type = string }
variable "username" {
  type        = string
  description = "Username to create on the VM"
  default     = "ubuntu"
}
variable "password" {
  type        = string
  description = "Plaintext password for the VM user (will be hashed for cloud-init)"
  sensitive   = true
}


variable "ip_address"    { type = string }
variable "cidr_prefix"   { type = number }
variable "gateway"       { type = string }
variable "nameservers"   { type = list(string) }

variable "web_password" {
  type      = string
  sensitive = true
}
variable "dns_upstream1" { type = string }
variable "dns_upstream2" { type = string }

variable "ssh_authorized_key" { type = string }
