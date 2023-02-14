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
  name     = "${var.vm_name}-0${count.index + 1}"
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
    label = "DATA-DISK1"
    size        = 250
    datastore_id = data.vsphere_datastore.datastore_data.id
    unit_number = 2
    # thin_provisioned = false
    # eagerly_scrub = true
  }


  disk {
    label = "DATA-DISK2"

    size        = var.data_disk
    datastore_id = data.vsphere_datastore.datastore_data.id
    unit_number = 3
    # thin_provisioned = false
    # eagerly_scrub = true
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

provisioner "file" {
    source = "scripts/resizefs.sh"
    destination = "/home/ansible/resizefs.sh"
    
  }
  connection {
    type     = "ssh"
    user     = "ansible"
    #private_key = file("/var/lib/jenkins/ansible.key")
    private_key = file(var.ansible_key)
    #password = var.ansible_key
    host     = self.default_ip_address
    script_path = "/home/ansible/tmp_resizefs.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "set -x",
      "chmod +x /home/ansible/*sh",
      "sudo sh /home/ansible/resizefs.sh"
    ]
  }


locals {
  mydata = zipmap(vsphere_virtual_machine.vm.*.name, vsphere_virtual_machine.vm.*.default_ip_address)
  ndata = join(" ", [for key, value in local.mydata : "${key},${value}"])
}


data "template_file" "config-vars" {
  template = file("${path.module}/templates/cluster-config-vars.template")
  vars = {
    XX_HOST_IPS_XX = local.ndata
    XX_SSH_USER_XX = var.ssh_user
    XX_KSVER_XX = var.kubespray_version
    XX_K8SVER_XX = var.k8s_version
    XX_PXOP_XX = var.px_operator_version
    XX_PXSTG_XX = var.px_stg_version
    XX_CPH_XX = var.cp_node_count
    XX_CLUSTER_NAME_XX = var.cluster_name
    XX_PX_SECURITY_XX = var.px_security
    }
}

resource "local_file" "cluster-config-vars" {
  content  = "${data.template_file.config-vars.rendered}"
  filename = "${path.root}/cluster-config-vars"
}

resource "null_resource" "local_setup" {
  depends_on = [
    vsphere_virtual_machine.vm
  ]
  provisioner "local-exec" {
    command = <<-EOT
      cp -p templates/find-kvdb-dev.sh templates/add-node.sh templates/remove-node.sh templates/kvdb-dev.yaml .
      cat templates/vars.template > vars
      chmod a+x vars
      EOT
      interpreter = ["/bin/bash", "-c"]
      working_dir = path.module
  }
}

module "k8s_setup" {
  depends_on = [null_resource.local_setup, local_file.cluster-config-vars]
  source = "./modules/k8s_setup"
}

module "portworx" {
  depends_on = [ module.k8s_setup ]
  source = "./modules/portworx"
}

resource "time_sleep" "wait_5_minutes" {
  depends_on = [ module.portworx ]
  create_duration = "5m"
}

module "portworx_data_services" {
  depends_on = [ module.portworx, time_sleep.wait_5_minutes, null_resource.pds_remove  ]
  source = "./modules/portworx_data_services"
  tenant_id = var.tenant_id
  px_operator_version = var.px_operator_version
  pds_token = var.pds_token
  pds_name = var.pds_name
  #helm_version = var.helm_version
  account_id = var.account_id
}

data "external" "get_cluster_id" {
  depends_on = [ module.k8s_setup ]
  program = ["sh", "-c", "/usr/local/bin/kubectl --kubeconfig ./modules/k8s_setup/kube-config-file get namespace kube-system -o jsonpath='{\"{\"}\"cluster-id\": \"{.metadata.uid}\"}'"]
}

locals {
extd = data.external.get_cluster_id.result
}

resource "null_resource" "pds_remove" {
  triggers = {
    deploy_id = local.extd.cluster-id
    token_id = var.pds_token
    tenant_id = var.tenant_id
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
       echo "Waiting for uninstall to finish"
       sleep 420
       echo "Removing PDS Entry"
       bash scripts/rm-pds-entry.sh ${self.triggers.token_id} ${self.triggers.tenant_id} ${self.triggers.deploy_id}
      EOT
      interpreter = ["/bin/bash", "-c"]
      working_dir = path.module
  }
}



output "info_vm_ips" {
  value = vsphere_virtual_machine.vm.*.default_ip_address
}

output "info_vm_names" {
  value = vsphere_virtual_machine.vm.*.name
}
