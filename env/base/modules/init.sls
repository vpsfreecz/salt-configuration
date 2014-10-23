/etc/rc.d/rc.local:
  file.managed:
    - source: salt://modules/conf/rc.local
    - template: jinja
    - defaults:
      modules: {{ (' ').join(pillar['vzkernel']['modules']) }}

{% for module in pillar['vzkernel']['modules'] %}
kernel-module-{{ module.replace('_', '-') }}:
  module.run:
    - name: kmod.load
    - mod: {{ module }}
{% endfor %}
