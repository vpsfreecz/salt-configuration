{% set fqdn = '_'.join(grains['fqdn'].split('.')|reverse) %}

zfs:
  service.running:
    - enable: True
    - name: zfs

zpool-vz:
  cmd.run:
    - name: zpool create -f vz {{ pillar[fqdn]['zfs_zpool']['vz']  }}
    - onlyif: zpool list | grep "no pools available"

zpool-vz-log:
  cmd.run:
    - name: zpool add -f vz log {{ pillar[fqdn]['zfs_zpool']['vz_log']  }}
    - unless: zpool status | grep -Pzo "logs"

zpool-vz-cache:
  cmd.run:
    - name: zpool add -f vz cache {{ pillar[fqdn]['zfs_zpool']['vz_cache']  }}
    - unless: zpool status | grep -Pzo "cache"

zfs-vz-template:
  cmd.run:
    - name: zfs create vz/template
    - unless: zfs list | grep -Pzo "template"

zfs-vz-private:
  cmd.run:
    - name: zfs create vz/private
    - unless: zfs list | grep -Pzo "private"

zfs-vz-root:
  cmd.run:
    - name: zfs create vz/root
    - unless: zfs list | grep -Pzo "root"

zfs-set-compression:
  cmd.run:
    - name: zfs set compression=on vz

zfs-set-acltype:
  cmd.run:
    - name: zfs set acltype=posixacl vz

zfs-set-atime:
  cmd.run:
    - name: zfs set atime=off vz

/vz/lock:
  file.directory

/vz/dump:
  file.directory

/vz/template/cache:
  file.directory
