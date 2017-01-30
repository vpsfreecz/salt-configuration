{% set fqdn = '_'.join(grains['fqdn'].split('.')|reverse) %}
{% set locality = '_'.join(grains['fqdn'].split('.')[1:]|reverse) %}

network:
  service.running:
    - name: network
    - require:
      - pkg: bird

bird:
  pkg.installed:
    - name: bird
  service.running:
    - enable: True
    - require:
      - pkg: bird

/etc/sysconfig/network:
  file.managed:
    - source: salt://network/conf/network
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      hostname: {{ grains['fqdn'] }}

/etc/sysconfig/network-scripts/ifcfg-eth0:
  file.managed:
    - source: salt://network/conf/ifcfg-ethx
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      eth: 0

/etc/sysconfig/network-scripts/ifcfg-eth1:
  file.managed:
    - source: salt://network/conf/ifcfg-ethx
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      eth: 1

/etc/sysconfig/network-scripts/ifcfg-eth0.{{ pillar[locality]['net_bond_vlan'] }}:
  file.managed:
    - source: salt://network/conf/ifcfg-ethx.vlan
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      eth: 0
      vlan: {{ pillar[locality]['net_bond_vlan'] }}

/etc/sysconfig/network-scripts/ifcfg-eth1.{{ pillar[locality]['net_bond_vlan'] }}:
  file.managed:
    - source: salt://network/conf/ifcfg-ethx.vlan
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      eth: 1
      vlan: {{ pillar[locality]['net_bond_vlan'] }}

/etc/modprobe.d/bond{{ pillar[locality]['net_bond_vlan'] }}.conf:
  file.managed:
    - source: salt://network/conf/bond.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      net_bond_vlan: {{ pillar[locality]['net_bond_vlan'] }}

/etc/sysconfig/network-scripts/ifcfg-bond{{ pillar[locality]['net_bond_vlan'] }}:
  file.managed:
    - source: salt://network/conf/ifcfg-bond
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      net_bond_vlan: {{ pillar[locality]['net_bond_vlan'] }}
      net_bond_opts: {{ pillar[locality]['net_bond_opts'] }}
      ip: {{ pillar[fqdn]['ip_addr'] }}
      ip6: {{ pillar[fqdn]['ip6_addr'] }}
      netmask: {{ pillar[locality]['netmask'] }}

/etc/bird.conf:
  file.managed:
    - source: salt://network/conf/bird.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      net_bond_vlan: {{ pillar[locality]['net_bond_vlan'] }}
      ip: {{ pillar[fqdn]['ip_addr'] }}
      net_ospf_area: {{ pillar[locality]['net_ospf_area'] }}
      net_ospf_networks: {{ pillar[locality]['net_ospf_networks'] }}

/etc/bird6.conf:
  file.managed:
    - source: salt://network/conf/bird6.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      net_bond_vlan: {{ pillar[locality]['net_bond_vlan'] }}
      ip: {{ pillar[fqdn]['ip_addr'] }}
      net_ospf_area: {{ pillar[locality]['net_ospf_area'] }}
      net_ospf_networks: {{ pillar[locality]['net_ospf_networks'] }}
      net_ospf6_networks: {{ pillar[locality]['net_ospf6_networks'] }}

/etc/resolv.conf:
  file.managed:
    - source: salt://network/conf/resolv.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
