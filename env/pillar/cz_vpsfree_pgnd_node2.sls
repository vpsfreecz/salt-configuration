cz_vpsfree_pgnd_node2:
  vpsadmin_server_id: '999'
  vpsadmin_location: 'Playground'
  vpsadmin_maxvps: '10'
  vpsadmin_fstype: 'zfs_compat'
  ip_addr: '172.16.2.11'
  ip6_addr: ''
  zfs_zpool:
    vz: 'mirror sda5 sdb5'
    vz_log: 'mirror sda2 sdb2'
    vz_cache: 'sda3 sdb3'
