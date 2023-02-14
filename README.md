<img src="icon.png" align="right" />

# Terraform-iac README

> Infrastructure as Code - Terraform to provision Kubernetes on public cloud environments


Terraform-iac contains step by step guide to provision Kubernetes clusters on public code using the terraform code (library) and shell scripts

This repo helps in creating the Kubernetes cluster with Portworx embedded on various cloud providers such as aws, azure, gcloud with portworx installed

## PreRequisites
install libffi-devel
install python3.8

make sure the ansible private key is kept under home directory as 'ansible.key'

export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_PRIVATE_KEY_FILE=~/ansible.key



Run common playbook to update yum repo


## License

To the extent possible under law, [Purestorage/portworx](https://purestorage.com) has waived all copyright and related or neighboring rights to this work
