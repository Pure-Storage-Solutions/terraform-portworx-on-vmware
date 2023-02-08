vsphere_server = "10.21.93.100"
vsphere_user = "unnir"
vsphere_password = "Pure1@#$"

#common
internal_domain = "puretec.purestorage.com."
vmSubnet = "VLAN2152"
dns_servers = ["10.21.237.250"]
cluster = "fb-radha-hosts"

osguest_id = "rhel8_64Guest"

vm_gateway = "10.21.152.1"
vm_ip = ["10.21.152.164", "10.21.152.165", "10.21.152.168", "10.21.152.169"]

dc = ""
vm_name          = "pds-vm"
vm_count         = 4
vm_cpus = 8
vm_memory = 8384
vmware_os_template    = "rhel8_packer11082022"
network = "10.21.152.0"
netmask = 24
os_disk    = 100
data_disk = 500

os_datastore = "sn1-m70-g01-32-fb-radha-hosts-vol"
data_datastore = "sn1-m70-g01-32-fb-radha-hosts-vol"
