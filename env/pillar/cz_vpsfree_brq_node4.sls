#FIXME: need to figure out how to override this, or just state
#it explicitely for each node..
#net:
#  ifaces:
#  - eth0
#  - eth1
#  - eth2
#  - eth3

cz_vpsfree_brq_node4:
  vpsadmin_server_id: '213'
  vpsadmin_location: 'Brno'
  vpsadmin_maxvps: '110'
  vpsadmin_fstype: 'zfs_compat'
  ip_addr: '172.19.0.13'
  ip6_addr: ''
  zfs_zpool:
    vz: 'raidz2 nvme0n1 nvme1n1 nvme2n1 nvme3n1'
    vz_log: 'mirror sda2 sdb2'
    vz_cache: 'sda3 sdb3'
