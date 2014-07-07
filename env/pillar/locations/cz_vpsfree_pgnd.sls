cz_vpsfree_pgnd:
  root_authorized_keys: ['snajpa', 'aither', 'medved']
  net_bond_vlan: '210'
  net_bond_opts: 'mode=balance-xor xmit_hash_policy=layer3+4 arp_interval=1000 arp_ip_target=172.16.2.1,172.16.2.2'
  net_ospf_area: '172.16.2.0'
  net_ospf_networks: ['172.16.2.0/23','185.8.164.0/25']
  net_ospf6_networks: '2a00:cb40:1::/48'
  netmask: '255.255.254.0'
