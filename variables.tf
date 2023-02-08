variable "vm_count" {

}
variable "vm_name" {
  type        = string
  description = "Name of VM"
}

variable "network" {}
variable "netmask"  {}
variable "vmware_os_template" {}
variable "vm_cpus" {}
variable "vm_memory" {}

variable "vm_ip" {}
variable "dns_servers" {
  type = list
}
variable "osguest_id" {}
variable "internal_domain" {}
variable "vm_gateway" {}
variable "vmSubnet" {}
variable "os_disk" {}
variable "data_disk" {}
variable "dc" {}
variable "cluster" {}
variable "vsphere_password" {

}

variable "vsphere_user" {}


variable "vsphere_server" {

}
variable "os_datastore" {

}
variable "data_datastore" {

}
