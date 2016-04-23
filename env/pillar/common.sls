nagios:
  std_plugin_dir: /usr/lib64/nagios/plugins/
  ruby_plugin_dir: /usr/lib64/nagios/ruby_plugins/
  other_plugin_dir: /usr/lib64/nagios/other_plugins/

  plugins:
    std:
    - check_disk
    - check_load
    - check_procs
    ruby:
    - check_cpu_perf
    - check_vpsadmind
    - check_vpsadmind_workers
    - check_zfs
    other:
    - check_mem
    - check_mount
    - check_yum
    - check_ipv6

# std matches nagios-plugins-<name> package
