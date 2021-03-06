install-openvz:
  pkg.installed:
    - pkgs:
      - vzctl
      - vzquota

remove-non-openvz-kernel:
  pkg.removed:
    - pkgs:
      - kernel
      - kernel-firmware

vz-stop:
  cmd.run:
    - name: service vz stop
    - onlyif: zpool list | grep "no pools available"

disable-vz:
  service.disabled:
    - name: vz

/etc/vz/vz.conf:
  file.managed:
    - source: salt://openvz/conf/vz.conf

/etc/vz/osrelease.conf:
  file.managed:
    - source: salt://openvz/conf/osrelease.conf

remove-vz:
  cmd.run:
    - name: rm -rf /vz
    - onlyif: zpool list | grep "no pools available"
