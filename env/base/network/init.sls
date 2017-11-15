{% set fqdn = '_'.join(grains['fqdn'].split('.')|reverse) %}
{% set locality = '_'.join(grains['fqdn'].split('.')[1:]|reverse) %}

network:
  service.running:
    - name: network
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

{% for iface in pillar['net']['ifaces'] %}
/etc/sysconfig/network-scripts/ifcfg-{{ iface }}:
  file.managed:
    - source: salt://network/conf/ifcfg-ethx
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      iface: {{ iface }}

/etc/sysconfig/network-scripts/ifcfg-{{ iface }}.{{ pillar[locality]['net_bond_vlan'] }}:
  file.managed:
    - source: salt://network/conf/ifcfg-ethx.vlan
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      iface: {{ iface }}
      vlan: {{ pillar[locality]['net_bond_vlan'] }}
{% endfor %}

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

/etc/resolv.conf:
  file.managed:
    - source: salt://network/conf/resolv.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
