install-abrt:
  pkg.installed:
    - pkgs:
      - abrt-addon-kerneloops
      - abrt-cli
      - libreport-plugin-mailx

/etc/abrt/abrt.conf:
  file.managed:
    - source: salt://abrt/conf/abrt.conf

/etc/abrt/abrt-action-save-package-data.conf:
  file.managed:
    - source: salt://abrt/conf/abrt-action-save-package-data.conf

/etc/libreport/events.d/koops_event.conf:
  file.managed:
    - source: salt://abrt/conf/libreport_koops_event.conf

/etc/libreport/events.d/mailx_event.conf:
  file.managed:
    - source: salt://abrt/conf/libreport_mailx_event.conf

abrt-ccpp:
  service.dead:
    - enable: False

abrtd:
  service.running:
    - enable: True
