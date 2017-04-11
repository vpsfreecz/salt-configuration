cz_vpsfree_pgnd_node2:
  vpsadmin_server_id: '301'
  vpsadmin_location: 'Playground'
  vpsadmin_maxvps: '120'
  vpsadmin_fstype: 'zfs_compat'
  ip_addr: '172.16.2.11'
  ip6_addr: ''
  zfs_zpool:
    vz: 'mirror sda sdb mirror sde sdf mirror sdg sdh'
    vz_log: 'mirror sdc2 sdd2'
    vz_cache: 'sdc3 sdd3'
