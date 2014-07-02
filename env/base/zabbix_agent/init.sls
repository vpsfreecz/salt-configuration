zabbix-repo:
  cmd.run:
    - name: rpm -Uvh http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm
    - unless: ls /etc/pki/rpm-gpg/ | grep "ZABBIX"

zabbix-agent:
  pkg.installed:
    - name: zabbix-agent
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://zabbix_agent/conf/zabbix_agentd.conf
    - template: jinja
    - defaults:
      server: 172.16.8.1
    - require:
      - pkg: zabbix-agent
  service.running:
    - enable: True
    - watch:
      - pkg: zabbix-agent
      - file: zabbix-agent

/var/www/zabbix/freemem.sh:
  file.managed:
    - source: salt://zabbix_agent/scripts/freemem.sh
    - user: zabbix
    - group: zabbix
    - mode: 755
    - makedirs: True
    - require:
      - pkg: zabbix-agent

/var/www/zabbix/zfs.sh:
  file.managed:
    - source: salt://zabbix_agent/scripts/zfs.sh
    - user: zabbix
    - group: zabbix
    - mode: 755
    - makedirs: True
    - require:
      - pkg: zabbix-agent

/var/www/zabbix/system_cpu_temp.py:
  file.managed:
    - source: salt://zabbix_agent/scripts/system_cpu_temp.py
    - user: zabbix
    - group: zabbix
    - mode: 755
    - makedirs: True
    - require:
      - pkg: zabbix-agent

/var/www/zabbix/ipv6.sh:
  file.managed:
    - source: salt://zabbix_agent/scripts/ipv6.sh
    - user: zabbix
    - group: zabbix
    - mode: 755
    - makedirs: True
    - require:
      - pkg: zabbix-agent

/etc/zabbix/zabbix_agentd.d/userparameter_vpsfree.conf:
  file.managed:
    - source: salt://zabbix_agent/conf/userparameter_vpsfree.conf
    - require:
      - pkg: zabbix-agent

/etc/sudoers.d/zabbix_sudo:
  file.managed:
    - source: salt://zabbix_agent/conf/zabbix_sudo
    - require:
      - pkg: zabbix-agent

restart-pkg-install:
  cmd.wait:
    - name: /etc/init.d/zabbix-agent restart
    - watch:
      - pkg: zabbix-agent
      - file: /etc/zabbix/zabbix_agentd.conf
      - file: /etc/zabbix/zabbix_agentd.d/userparameter_vpsfree.conf
