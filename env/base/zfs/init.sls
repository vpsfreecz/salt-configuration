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

zfs-sharenfs:
  cmd.run:
    - name: zfs set sharenfs="rw=@172.16.0.0/23,no_root_squash" vz/private

/vz/lock:
  file.directory

/vz/dump:
  cmd.run:
    - name: zfs create vz/dump
    - unless: zfs list | grep -Pzo "dump"

/vz/template:
  file.directory

/etc/fstab:
  file.append:
    - text:
      - 172.16.0.5:/storage/vpsfree.cz/template /vz/template nfs vers=3,rw,noatime 0 0

mount-a:
  cmd.wait:
    - name: mount -a
    - watch:
      - file: /etc/fstab
