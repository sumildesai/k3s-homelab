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
  - apt-get install -y curl vim net-tools

  # 1. Enable IP forwarding permanently
  - echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
  - echo 'net.ipv6.conf.all.forwarding=1' >> /etc/sysctl.conf
  - sysctl -p

  # 2. Install Tailscale
  - curl -fsSL https://tailscale.com/install.sh | sh

  # 3. Enable and start Tailscale service
  - systemctl enable --now tailscaled

  # 4. Bring up Tailscale with advertised subnet routes
  # 5. Accept subnet routes automatically 
  - tailscale up --advertise-routes=192.168.50.0/24 --accept-routes=true
