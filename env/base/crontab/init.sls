/etc/crontab:
  file.managed:
    - source: salt://crontab/conf/empty.conf
