cz_vpsfree_brq:
  root_authorized_keys: ['snajpa', 'aither', 'medved']
  net_bond_vlan: '200'
  net_bond_opts: 'mode=1 miimon=100'
  net_ospf_area: '0.0.0.0'
  net_ospf_networks: ['172.19.0.0/23','37.205.11.0/24']
  net_ospf6_networks: '2a00:cb40:2::/48'
  netmask: '255.255.254.0'
