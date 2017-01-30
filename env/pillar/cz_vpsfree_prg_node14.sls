#FIXME: need to figure out how to override this, or just state
#it explicitely for each node..
#net:
#  ifaces:
#  - eth0
#  - eth1
#  - eth2
#  - eth3

cz_vpsfree_prg_node14:
  vpsadmin_server_id: '115'
  vpsadmin_location: 'Praha'
  vpsadmin_maxvps: '80'
  vpsadmin_fstype: 'zfs_compat'
  ip_addr: '172.16.0.24'
  ip6_addr: ''
  zfs_zpool:
    vz: 'raidz2 sda sdb sdc sdd sde sdf sdg sdh'
    vz_log: 'mirror sdi2 sdj2'
    vz_cache: 'sdi3 sdj3'
