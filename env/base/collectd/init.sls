install-collectd:
  pkg.installed:
    - pkgs:
      - collectd5
      - collectd5-ipmi
      - collectd5-sensors
      - collectd5-smart
      - OpenIPMI
      - freeipmi

kernel-module-ipmi_devintf:
  module.run:
    - name: kmod.load
    - mod: ipmi_devintf

/etc/collectd.conf:
  file.managed:
    - source: salt://collectd/conf/collectd.conf
    - template: jinja
    - defaults:
      hostname: {{ grains['fqdn'] }}

/etc/collectd.d/graphite.conf:
  file.managed:
    - source: salt://collectd/conf/graphite.conf

collectd:
  service.running:
    - enable: True
    - watch:
      - file: /etc/collectd.conf
      - file: /etc/collectd.d/graphite.conf
