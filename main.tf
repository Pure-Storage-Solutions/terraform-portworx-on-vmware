# resource "local_file" "name" {
#     filename = var.vm_cluster
#     for_each = var.data_disks
#     content = each.value["size"]

# }
terraform {
  required_providers {

    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.1.1"
    }
  }
}


## Configure the vSphere Provider

provider "vsphere" {
  vsphere_server = var.vsphere_server
  user           = var.vsphere_user
  password       = var.vsphere_password
  #password = data.vault_generic_secret.vcpass.data["tfuser"]
  allow_unverified_ssl = true
}

## Build VM
data "vsphere_datacenter" "datacenter" {
  name = var.dc
}

data "vsphere_datastore" "datastore_os" {
  name = var.os_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore_data" {
  name = var.data_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.cluster}/Resources"
  #name          = "${var.resource_pool}"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vmSubnet
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name = var.vmware_os_template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  #depends_on = infoblox
  count            = var.vm_count
  name     = "${var.vm_name}_0${count.index + 1}"
  #hostname = "${var.vm_name}${count.index + 1}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore_os.id
  num_cpus = var.vm_cpus
  memory   = var.vm_memory
  num_cores_per_socket = 2
  sync_time_with_host = true
  guest_id = var.osguest_id
  scsi_controller_count = 4
  #scsi_bus_sharing = "physicalSharing"

  network_interface {
    network_id   = data.vsphere_network.network.id
  }
  disk {
    label = "BOOT-DISK"
    unit_number = 0
    size  = 2
    thin_provisioned = true

  }
  disk {
    label = "OS-DISK"
    unit_number = 1
    size  = var.os_disk
    thin_provisioned = true

  }

    disk {
    label = "data-DISK"
    unit_number = 2
    size  = var.data_disk
    thin_provisioned = true

  }



  clone {

    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {

        #host_name = var.vm_name
        host_name = format("%s-%d", var.vm_name ,count.index +1)
        domain    = trimsuffix( var.internal_domain, "." )  #"puretec.purestorage.com"
      }
      network_interface {
        #ipv4_address = phpipam_first_free_address.new_ip[count.index].ip_address
        #ipv4_address = "10.21.152.${164 + count.index}"
        ipv4_address = var.vm_ip[count.index]
        ipv4_netmask = var.netmask
      }
       ipv4_gateway    = var.vm_gateway
       dns_suffix_list = [var.internal_domain]
       dns_server_list = var.dns_servers
    }
  }

}

locals {
  mydata = zipmap(vsphere_virtual_machine.vm.*.name, vsphere_virtual_machine.vm.*.default_ip_address)
  ndata = join(" ", [for key, value in local.mydata : "${key},${value}"])
}
