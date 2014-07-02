cz_vpsfree_prg_node1:
  vpsadmin_server_id: '101'
  vpsadmin_location: 'Praha'
  vpsadmin_maxvps: '80'
  vpsadmin_fstype: 'zfs_compat'
  ip_addr: '172.16.0.10'
  ip6_addr: ''
  zfs_zpool:
    vz: 'mirror sda sdb mirror sde sdf mirror sdg sdh'
    vz_log: 'mirror sdc2 sdd2'
    vz_cache: 'sdc3 sdd3'
