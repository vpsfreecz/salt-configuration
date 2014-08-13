vzkernel-{{ pillar['vzkernel']['version'] }}:
  pkg.installed:
    - name: vzkernel
    - version: {{ pillar['vzkernel']['version'] }}

install-spl-zfs:
  pkg.installed:
    - pkgs:
      - spl
      - zfs

kmod-spl:
  pkg.installed:
    - name: kmod-spl-{{ pillar['vzkernel']['version'] }}

kmod-zfs:
  pkg.installed:
    - name: kmod-zfs-{{ pillar['vzkernel']['version'] }}

yum-check-update:
  cmd.wait:
    - name: yum check-update
    - require:
      - pkg: vzkernel-{{ pillar['vzkernel']['version'] }}
      - pkg: install-spl-zfs
      - pkg: kmod-spl-{{ pillar['vzkernel']['version'] }}
      - pkg: kmod-zfs-{{ pillar['vzkernel']['version'] }}
