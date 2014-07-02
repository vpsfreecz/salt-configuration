{% set fqdn = '_'.join(grains['fqdn'].split('.')|reverse) %}

nginx:
  pkg.installed:
    - name: nginx
    - require:
      - file: nginx-repo
  service.running:
    - enable: True
    - require:
      - pkg: nginx
    - watch:
      - file: nginx-config
      - file: /etc/nginx/conf.d/*
    - order: last

nginx-repo:
  file.managed:
    - name: /etc/yum.repos.d/nginx.repo
    - source: salt://nginx/repo/nginx.repo

nginx-config:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/conf/nginx.conf
    - require:
      - pkg: nginx

nginx-vhost-default:
  file.managed:
    - name: /etc/nginx/conf.d/default.conf
    - source: salt://nginx/vhosts/default.nginx
    - makedirs: True
    - require:
      - pkg: nginx

{% for vhost in pillar[fqdn]['nginx_vhosts'] %}

{% set ssl = pillar[fqdn]['nginx_vhosts'][vhost]['ssl'] %}
{% set crt = pillar[fqdn]['nginx_vhosts'][vhost]['crt'] %}
{% set crt_key = pillar[fqdn]['nginx_vhosts'][vhost]['crt_key'] %}

{% if ssl %}
ssl-{{ vhost }}-{{ crt }}:
  file.managed:
    - name: /etc/ssl/{{ crt }}
    - source: https://secret.vpsfree.cz/ssl/{{ crt }}
    - source_hash: https://secret.vpsfree.cz/ssl/{{ crt }}.md5
    - user: root
    - group: root

ssl-{{ vhost }}-{{ crt_key }}:
  file.managed:
    - name: /etc/ssl/{{ crt_key }}
    - source: https://secret.vpsfree.cz/ssl/{{ crt_key }}
    - source_hash: https://secret.vpsfree.cz/ssl/{{ crt_key }}.md5
    - user: root
    - group: root
{% endif %}

nginx-vhost-{{ vhost }}-dir:
  file.directory:
    - name: /var/www/{{ fqdn }}/{{ vhost }}
    - user: nginx
    - group: nginx
    - mode: 755
    - makedirs: True

nginx-vhost-{{ vhost }}:
  file.managed:
    - name: /etc/nginx/conf.d/{{ vhost }}.conf
    - source: salt://nginx/vhosts/template.nginx
    - template: jinja
    - defaults:
      fqdn: {{ fqdn }}
      vhost: {{ vhost }}
      ssl : {{ ssl }}
      crt: {{ crt }}
      crt_key: {{ crt_key }}
{% endfor %}
