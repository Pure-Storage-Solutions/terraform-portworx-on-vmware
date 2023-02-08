variable "dc" {
  type = string
  default = ""
  
}

variable "vsphere_server" {
  type = string
  default = "10.21.93.100"
}

variable "vsphere_user" {
  type = string
  default = "unnir"
}

variable "vsphere_password" {
  type = string
}
variable "datastore_os" {
  type = string
  default = "sn1-m70-g01-32-fb-radha-hosts-vol"
  
}

variable "datastore_data" {
  type = string
  default = "sn1-m70-g01-32-fb-radha-hosts-vol"  
}

variable "cluster" {
  type = string
  default = "fb-radha-hosts"

  
}

variable "vmSubnet" {
  type = string
  default = "VLAN2152"

}

variable "vmware_os_template" {
  type = string
  default = "rhel8_packer11082022"
  
}

variable "vm_cpus" {
  default = 8
  
}


variable "vm_memory" {

  default = 8384
  
}

variable "osguest_id" {
  type = string
  default = "rhel8_64Guest"
  
}

variable "data_disk_size1" {
  default = 250
  
}

variable "data_disk_size2" {
  default = 500
  
}

variable "ip" {
  
  default = ["10.21.152.164","10.21.152.165"]


}

variable "netmask" {
  default = 24
  
}

variable "gateway" {
  type = string
  default = "10.21.152.1"
  
}

variable "internal_domain" {
  type = string
  default = "puretec.purestorage.com."
  
}
variable "dns_servers" {
  type = list
  default = ["10.21.237.250"]
  
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
  default     = "root"
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

