# k3s-homelab

This project automates the setup of a simple [k3s](https://k3s.io/) Kubernetes cluster on [xcp-ng](https://xcp-ng.org/) using **Terraform** and **Ansible**. It also includes a Kubernetes controller to automate network access and service exposure.

## Features
- Automated provisioning of VMs on xcp-ng with Terraform
- Automated k3s cluster installation and configuration with Ansible
- Optional deployment of Pi-hole for network-wide ad blocking
- Cloud-init templates for VM initialization
- Modular and extensible structure

## Prerequisites
- xcp-ng server with API access
- Terraform
- Ansible
- SSH access to target hosts

## Folder Structure
```
ansible/        # Ansible playbooks and inventory
terraform/      # Terraform modules and configuration
```

## Usage
1. **Clone this repository**
2. **Configure your variables** in `terraform/variables.tf` and `ansible/inventory.yml`
3. **Provision infrastructure**:
	```sh
	cd terraform
	terraform init
	terraform apply
	```
4. **Configure the cluster**:
	```sh
	cd ../ansible
	ansible-playbook -i inventory.yml k3s-cluster.yml
	```

## Notes
- Review and customize the cloud-init templates as needed for your environment.
- See individual module and playbook files for more details and customization options.

---
**Author:** [sumildesai](https://github.com/sumildesai)
