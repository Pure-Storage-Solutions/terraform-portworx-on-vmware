variable "vm_count" {
  description = "Number of VM to buuild"
  default = 4
}
variable "vm_name" {
  type        = string
  description = "Name of VM"
  default = "pds-vm"
}

variable "network" {
  description = "IP subnet to build the VM"
  default = "10.21.152.0"
}
variable "netmask"  {
  description = "Netmask for the VM subnet"
  default = 24
}
variable "vmware_os_template" {
  description = "Name of the OS template to clone the VM"
  default = "rhel8_packer11082022"
}
variable "vm_cpus" {
  description = "Number of CPUs for the  VM"
  default = 8
}
variable "vm_memory" {
  description = "Memory for the VM"
  default = 8384
  }

variable "vm_ip" {
  description = "List of IPs to use for the VMs."
  default = ["10.21.152.164", "10.21.152.165", "10.21.152.168", "10.21.152.169"]
}
variable "dns_servers" {
  description = "List of DNS servers to use"
  type = list
  default = ["10.21.237.250"]
}
variable "osguest_id" {
  description = "VMware Guest OS id. This will change with OS flavour"
  default = "rhel8_64Guest"
}
variable "internal_domain" {
  description = "Internal domain name"
  dedefault = "puretec.purestorage.com."
}
variable "vm_gateway" {
  description = "Default network gateway for the VM "
  default = "10.21.152.1"
}
variable "vmSubnet" {
  description = "Name of the VMware subnet configured"
  default = "VLAN2152"
}
variable "os_disk" {
  description = "Size of the OS disk"
  default = 200
}
variable "data_disk" {
  description = "Size of the data disk"
  default = 500
}
variable "dc" {
  description = "VMware DC name"
  default = ""
}
variable "cluster" {
  description = "VMware cluster name"
  defdefault = "fb-radha-hosts"
}


variable "vsphere_server" {
  description = "Vcenter name or IP"
  default = "10.21.93.100"

}

variable "vsphere_user" {
  description = "Vcenter Administrator user"
  default = "unnir"
}

variable "vsphere_password" {
  description = "VCenter passsword"
}

variable "os_datastore" {
  description = "VMware datastore to create OS disk"
  default = "sn1-m70-g01-32-fb-radha-hosts-vol"

}
variable "data_datastore" {
  description = "VMware datastore to create Data disk"
  default = "sn1-m70-g01-32-fb-radha-hosts-vol"

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