/etc/crontab:
  file.managed:
    - source: salt://crontab/conf/empty.conf

/etc/cron.d/zfs-scrub-vz:
  file.managed:
    - source: salt://crontab/conf/zfs-scrub-vz
