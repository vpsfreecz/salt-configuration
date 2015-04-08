{% set fqdn = '_'.join(grains['fqdn'].split('.')|reverse) %}
{% set locality = '_'.join(grains['fqdn'].split('.')[1:]|reverse) %}


bundler:
  gem.installed

vpsadmind:
  git.latest:
    - name: git://37.205.10.42/vpsadmind.git
    - rev: master
    - target: /opt/vpsadmind
  cmd.wait:
    - cwd: /opt/vpsadmind
    - name: bundle install
    - watch:
      - git: vpsadmind

vpsadmindctl:
  git.latest:
    - name: git://37.205.10.42/vpsadmindctl.git
    - rev: master
    - target: /opt/vpsadmindctl
  cmd.wait:
    - cwd: /opt/vpsadmindctl
    - name: bundle install
    - watch:
      - git: vpsadmindctl

/etc/init.d/vpsadmind:
  file.symlink:
    - target: /opt/vpsadmind/scripts/vpsadmind.init

/etc/logrotate.d/vpsadmind:
  file.symlink:
    - target: /opt/vpsadmind/scripts/vpsadmind.logrotate

/usr/local/bin/vpsadmindctl:
  file.symlink:
    - target: /opt/vpsadmindctl/vpsadmindctl.rb

/etc/sysconfig/vpsadmind:
  file.managed:
    - source: salt://vpsadmin/conf/vpsadmind

/etc/vpsadmin/vpsadmind.yml:
  file.managed:
    - source: https://secret.vpsfree.cz/vpsadmin/vpsadmind.yml
    - source_hash: https://secret.vpsfree.cz/vpsadmin/vpsadmind.yml.md5
    - makedirs: True
    - template: jinja
    - defaults:
      vpsadmin_server_id: {{ pillar[fqdn]['vpsadmin_server_id'] }}
      net_bond_vlan: {{ pillar[locality]['net_bond_vlan'] }}
      ip_addr: {{ pillar[fqdn]['ip_addr'] }}

vpsadmind-service:
  service.enabled:
    - name: vpsadmind
    - require:
      - git: vpsadmind
      - git: vpsadmindctl
      - file: /etc/vpsadmin/vpsadmind.yml
      - file: /etc/sysconfig/vpsadmind

