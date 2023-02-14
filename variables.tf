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

variable "ansible_key" {
  
}

variable "account_id" {
  type = string
  default = "db4652ee-8937-47b2-952d-3b883fd2cb33"
  description = "Account id of PDS"
}

variable "tenant_id" {
  type = string
  default = "null"
  description = "Tenant id of PDS account"
}

variable "pds_token" {
  type = string
  default = "null"
  description = "Bearer token from PDS account page"
}

#variable "helm_version" {
#  type = string
#  default = "1.10.4"
#  description = "Helm version used during PDS install."
#}

variable "pds_name" {
  type = string
  default = "pds-demo-from-terraform"
  description = "Target Deployment name for cluster in PDS"
}

variable "px_security" {
  type        = string
  default     = "false"
  description = "Enable security for portworx or not"
}

variable "ssh_user" {
  type        = string
  default     = "ansible"
  description = "Username to connect baremetals"
}

variable "cp_node_count" {
  type        = number
  default     = 1
  description = "Number of control plane nodes in k8s cluster"
}

variable "kubespray_version" {
  type        = string
  default     = "2.20"
  description = "Version for Kubespray"
}

variable "px_operator_version" {
  type        = string
  default     = "1.10.1"
  description = "Version for Portworx Operator"
}

variable "k8s_version" {
  type        = string
  default     = "v1.23.0"
  description = "Version for K8s"
}

variable "px_stg_version" {
  type        = string
  default     = "2.12.0"
  description = "Version for Portworx Storage Cluster"
}

variable "cluster_name" {
  type        = string
  default     = "px-cluster"
  description = "Name of the portworx cluster"
}



variable "hostname" {
  type        = string
  default     = "pds-vmware"
  description = "Hostname for the nodes"
}


variable "nodes_count" {
  type        = number
  default     = 4
  description = "Number of baremetal nodes"
}