nrpe:
  pkg.installed:
  - name: nrpe

  service.running:
  - enable: True
  - watch:
    - file: /etc/nrpe.d/nrpe.cfg

nagiosplugin:
  gem.installed

mixlib-cli:
  gem.installed

/etc/nrpe.d/nrpe.cfg:
  file.managed:
  - source: salt://nagios/conf/nrpe.cfg
  - template: jinja

/etc/sudoers.d/nrpe:
  file.managed:
  - source: salt://nagios/conf/sudoers-nrpe
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
   - makedirs: True
{% endfor %}

{% for plugin in pillar['nagios']['plugins']['other'] %}
{{ pillar['nagios']['other_plugin_dir'] }}/{{ plugin }}:
  file.managed:
   - source: salt://nagios/plugins/other/{{ plugin }}
   - mode: 755
   - makedirs: True
{% endfor %}
