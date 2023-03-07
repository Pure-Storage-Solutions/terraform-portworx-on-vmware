variable "vcenter_details" {
  description = "VMCenter related inputs"
  type = object(
    {
      vsphere_server = string    #"Vcenter name or IP"
      vsphere_user = string              #"Vcenter Administrator user"

      dc = string                             #"VMware DC name"
      cluster = string          #"VMware cluster name"
    }
  )
  default = {
    cluster = "cluster1"
    dc = ""
    vsphere_server = "10.x.x.x" 
    vsphere_user = "Administrator"
  }
  
}

variable "vsphere_password" {
  description = "VCenter passsword"
  
}

variable "vm_compute" {
  description = "VM compute related inputs"
  type = object(
    {
      vm_count = number                                  #"Number of VM to build"
      vm_name = string                     #"Name of VM"
      vmware_os_template = string   #"Name of the OS template to clone the VM"
      osguest_id  =   string              #"VMware Guest OS id. This will change with OS flavour"
      vm_cpus = number                                   #"Number of CPUs for the  VM"
      vm_memory =  number                             #"Memory for the VM"
      vm_ip =   list(string)  #"List of IPs to use for the VMs."
      ansible_key =  string              #"Ansible private key"          

    }
  )
  default = {
    ansible_key = "~/ansible.key"
    osguest_id = "rhel8_64Guest" 
    vm_count = 4
    vm_cpus = 8
    vm_ip = ["10.0.0.5", "10.0.0.2", "10.0.0.3", "10.0.0.4"]
    vm_memory = 8384
    vm_name = "pds-vmware" 
    vmware_os_template = "rhel8_template"
  }
  
}

variable "vm_network" {
  description = "VM network related inputs"
  type = object(
    {
      network = string                       #"IP subnet to build the VM"
      netmask = number                                  #"Netmask for the VM subnet"
      vm_gateway = string                  #"Default network gateway for the VM "
      vmSubnet  = string                       #"Name of the VMware subnet configured"
      dns_servers =  list(string)             #"List of DNS servers to use"
      internal_domain = string  #"Internal domain name"
    }
  )
  default = {
    dns_servers = ["10.0.0.10"] 
    internal_domain = "example.com."
    netmask = 24
    network = "10.0.0.0"
    vmSubnet = "VLANxxx" 
    vm_gateway = "10.0.0.1"  
  }


  
}

variable "vm_storage" {
  description = "VM storage related inputs"
  type = object(
    {
      os_disk = number                                  #"Size of the OS disk"
      data_disk = number                                 #"Size of the data disk"
      os_datastore = string  #"VMware datastore to create OS disk"
      data_datastore = string  #"VMware datastore to create Data disk"
    }
  )
  default = {
    data_datastore = "ds1"
    data_disk = 500
    os_datastore = "ds2"
    os_disk = 200
  }

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


