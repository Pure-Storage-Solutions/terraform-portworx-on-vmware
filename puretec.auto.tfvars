vsphere_server = "10.21.93.100"
# vsphere_user = "root"
# vsphere_password = "Osmium76$"
vsphere_user = "unnir"
vsphere_password = "Pure1@#$"

#common
internal_domain = "puretec.purestorage.com."
vmSubnet = "VLAN2152"
dns_servers = ["10.21.237.250"]
cluster = "se-shared-test-pod"

osguest_id = "rhel8_64Guest"

vm_gateway = "10.21.152.1"
vm_ip = ["10.21.152.164", "10.21.152.165"]

dc = ""
vm_name          = "mysql-linux"
vm_count         = 2
vm_cpus = 4
vm_memory = 8384
vmware_os_template    = "rhel8_packer11082022"
network = "10.21.152.0"
netmask = 24
os_disk    = 50
data_disk = 50

os_datastore = "Template"
data_datastore = "Template"
