version: 1
config:
  - type: physical
    name: enX0
    subnets:
      - type: static
        address: ${ip_address}/${cidr_prefix}
        gateway: ${gateway}
        dns_nameservers:
%{ for ns in nameservers ~}
          - ${ns}
%{ endfor ~}
