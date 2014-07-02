/etc/yum.repos.d/openvz.repo:
  file.managed:
    - source: salt://repositories/conf/openvz.repo

/etc/yum.repos.d/sl.repo:
  file.managed:
    - source: salt://repositories/conf/sl.repo

/etc/yum.repos.d/vpsfree.repo:
  file.managed:
    - source: salt://repositories/conf/vpsfree.repo
