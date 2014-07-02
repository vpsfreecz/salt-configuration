/root/.ssh:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 600

/root/.ssh/id_dsa:
  file.managed:
    - source: https://secret.vpsfree.cz/ssh/id_dsa
    - source_hash: https://secret.vpsfree.cz/ssh/id_dsa.md5
    - user: root
    - group: root
    - mode: 600

/root/.ssh/id_dsa.pub:
  file.managed:
    - source: https://secret.vpsfree.cz/ssh/id_dsa.pub
    - source_hash: https://secret.vpsfree.cz/ssh/id_dsa.pub.md5
    - user: root
    - group: root
    - mode: 600

/root/.ssh/authorized_keys:
  file.managed:
    - source: https://secret.vpsfree.cz/ssh/authorized_keys
    - source_hash: https://secret.vpsfree.cz/ssh/authorized_keys.md5
    - user: root
    - group: root
    - mode: 600

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/conf/sshd_config
    - user: root
    - group: root

sshd:
  service.running:
    - watch:
      - file: /etc/ssh/sshd_config
