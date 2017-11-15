{% set fqdn = '_'.join(grains['fqdn'].split('.')|reverse) %}
{% set locality = '_'.join(grains['fqdn'].split('.')[1:]|reverse) %}

bird:
  pkg.installed:
    - name: bird
  service.running:
    - enable: True
    - require:
      - pkg: bird
    - watch:
      - file: /etc/bird.conf
      - file: /etc/bird6.conf

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
