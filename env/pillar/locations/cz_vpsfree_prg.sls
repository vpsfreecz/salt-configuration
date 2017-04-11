cz_vpsfree_prg:
  root_authorized_keys: ['snajpa', 'aither', 'sorki']
  net_bond_vlan: '200'
  net_bond_opts: 'mode=balance-xor xmit_hash_policy=layer3+4'
  net_ospf_area: '0.0.0.0'
  net_ospf_networks: ['172.16.0.0/23','172.16.8.0/21','83.167.228.0/25','77.93.223.0/26','77.93.223.64/26','77.93.223.192/26','37.205.8.0/23']
  net_ospf6_networks: ['2a01:430:17::/48']
  netmask: '255.255.254.0'
