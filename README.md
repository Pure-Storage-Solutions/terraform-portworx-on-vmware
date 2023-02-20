<img src="icon.png" align="right" />

# Terraform-iac README

Infrastructure as Code - Terraform to provision Kubernetes on public cloud environments


Terraform-iac contains step by step guide to provision Kubernetes clusters on VMware using the terraform code (library) and shell scripts.

This repo helps in creating the Kubernetes cluster with Portworx on VMware. 

## PreRequisites on the system running the terraform code. 
- install libffi-devel
- install python3.8

## Linux image
The Linix template we use to build the VM should have authentication method updated to use. 
If we are using ssh key based authentication, ssh private key should be saved on the system we execute terraform and export the path. 
If we have saved the ssh key as  'ansible.key' under home directory. 

- export ANSIBLE_HOST_KEY_CHECKING=False
- export ANSIBLE_PRIVATE_KEY_FILE=~/ansible.key

## License

To the extent possible under law, [Purestorage/portworx](https://purestorage.com) has waived all copyright and related or neighboring rights to this work
