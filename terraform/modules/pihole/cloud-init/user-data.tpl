#cloud-config
hostname: ${hostname}
chpasswd:
  expire: false
  users:
  - {name: ubuntu, password: ubuntu, type: text}
ssh_pwauth: True
manage_etc_hosts: true

users:
  - name: ${username}
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

write_files:
  - path: /etc/pihole/setupVars.conf
    permissions: "0644"
    owner: root:root
    content: |
      PIHOLE_INTERFACE=enX0
      IPV4_ADDRESS=${ip_address}/${cidr_prefix}
      PIHOLE_DNS_1=${dns_upstream1}
      PIHOLE_DNS_2=${dns_upstream2}
      INSTALL_WEB_SERVER=true
      INSTALL_WEB_INTERFACE=true
      LIGHTTPD_ENABLED=true
      DNSMASQ_LISTENING=single
      WEBPASSWORD=${web_password}

runcmd:
  - ufw disable
  - curl -sSL https://install.pi-hole.net | bash
