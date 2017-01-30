install-ntp:
  pkg.installed:
    - pkgs:
      - ntp

ntpd:
  service.running:
    - enable: True
