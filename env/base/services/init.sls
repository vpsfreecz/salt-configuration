/etc/sysctl.conf:
  file.managed:
    - source: salt://services/conf/sysctl.conf

sysctl:
  cmd.wait:
    - name: sysctl -p
    - watch:
      - file: /etc/sysctl.conf

cpuspeed:
  service.running:
    - enable: True

/etc/kdump.conf:
  file.managed:
    - source: salt://services/conf/kdump.conf

kdump:
  service.running:
    - enable: True
    - watch:
      - file: /etc/kdump.conf

/var/log/munin:
  file.directory:
    - user: munin
    - group: munin

munin-node:
  service.running:
    - enable: True

/etc/munin/munin-node.conf:
  file.managed:
    - source: salt://services/conf/munin-node.conf

/etc/crontab:
  file.managed:
    - source: salt://services/conf/crontab

rpcbind:
  service.running:
    - enable: True

nfs:
  service.running:
    - enable: True
