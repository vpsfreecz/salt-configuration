install-haveged:
  pkg.installed:
    - pkgs:
      - haveged

haveged:
  service.running:
    - enable: True
