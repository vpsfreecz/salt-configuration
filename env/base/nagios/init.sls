/etc/nrpe.d/nrpe.cfg:
  file.managed:
  - source: salt://nagios/conf/nrpe.cfg
  - template: jinja

{% for plugin in pillar['nagios']['plugins']['std'] %}
nagios-plugins-{{ plugin|replace('check_', '') }}:
  pkg.installed
{% endfor %}

{% for plugin in pillar['nagios']['plugins']['ruby'] %}
{{ pillar['nagios']['ruby_plugin_dir'] }}/{{ plugin }}:
  file.managed:
   - source: salt://nagios/plugins/{{ plugin }}
   - mode: 755
{% endfor %}

{% for plugin in pillar['nagios']['plugins']['other'] %}
{{ pillar['nagios']['other_plugin_dir'] }}/{{ plugin }}:
  file.managed:
   - source: salt://nagios/plugins/other/{{ plugin }}
   - mode: 755
{% endfor %} 
