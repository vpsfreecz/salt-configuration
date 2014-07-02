/etc/yum.repos.d/mariadb.repo:
  file.managed:
    - souce: salt://mariadb/repo/mariadb.repo

mariadb:
  pkg.installed:
    - name: MariaDB-server
  service.running:
    - name: mysql
    - watch:
      - file: /etc/my.cnf

/etc/my.cnf:
  file.managed:
    - source: salt://mariadb/conf/my.cnf
    - require:
      - pkg: mariadb
