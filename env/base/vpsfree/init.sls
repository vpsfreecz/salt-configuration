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
    - version: {{ pillar['vzkernel']['version_spl'] }}.el6

kmod-zfs:
  pkg.installed:
    - name: kmod-zfs-{{ pillar['vzkernel']['version'] }}
    - version: {{ pillar['vzkernel']['version_zfs'] }}.el6

yum-check-update:
  cmd.wait:
    - name: yum check-update
    - require:
      - pkg: vzkernel-{{ pillar['vzkernel']['version'] }}
      - pkg: install-spl-zfs
      - pkg: kmod-spl-{{ pillar['vzkernel']['version'] }}
      - pkg: kmod-zfs-{{ pillar['vzkernel']['version'] }}
