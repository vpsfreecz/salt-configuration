sensors:
  pkg.installed:
    - name: lm_sensors

sensors-detect:
  cmd.wait:
    - name: yes "" | sensors-detect
  require:
    - pkg: sensors
