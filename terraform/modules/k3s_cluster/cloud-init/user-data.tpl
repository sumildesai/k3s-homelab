#cloud-config
hostname: ${hostname}
chpasswd:
  expire: false
  users:
  - {name: ubuntu, password: ubuntu, type: text}
ssh_pwauth: True
manage_etc_hosts: true

users:
  - name: ubuntu
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: sudo
    shell: /bin/bash
    lock_passwd: false
    ssh_authorized_keys:
      - ${ssh_key}

package_update: true
package_upgrade: true
packages:
  - curl

runcmd:
  - apt-get update -y
  - apt-get upgrade -y
  - apt-get install -y curl vim git
  - ufw disable