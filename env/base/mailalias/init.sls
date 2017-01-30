root:
  alias.present:
    - target: admin@lists.vpsfree.cz

update-aliases:
  cmd.wait:
    - name: newaliases
    - runas: root
