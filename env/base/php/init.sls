php-repo:
  pkg.installed:
    - sources:
      - webtatic-release: http://mirror.webtatic.com/yum/el6/latest.rpm
    - order: 1

{% set v = '54w' %}

php_stack:
  pkg.installed:
    - name: php{{ v }}-fpm
    - require:
      - pkg: php-repo
  service.running:
    - name: php-fpm
    - enable: True
    - require:
      - pkg: php{{ v }}-fpm
      - pkg: php{{ v }}-gd
      - pkg: php{{ v }}-mcrypt
      - pkg: php{{ v }}-cli
      - pkg: php{{ v }}-pdo
      - pkg: php{{ v }}-xml
      - pkg: php{{ v }}-common
      - pkg: php-pear-Net-Curl
    - watch:
      - file: /etc/php-fpm.conf
      - file: /etc/php-fpm.d/www.conf

php_gd:
  pkg.installed:
    - name: php{{ v }}-gd

php_mcrypt:
  pkg.installed:
    - name: php{{ v }}-mcrypt

php_cli:
  pkg.installed:
    - name: php{{ v }}-cli

php_pdo:
  pkg.installed:
    - name: php{{ v }}-pdo

php_xml:
  pkg.installed:
    - name: php{{ v }}-xml

php_common:
  pkg.installed:
    - name: php{{ v }}-common

php_curl:
  pkg.installed:
    - name: php-pear-Net-Curl

/etc/php-fpm.conf:
  file.managed:
    - source: salt://php/conf/php-fpm.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php{{ v }}-fpm

/etc/php-fpm.d/www.conf:
  file.managed:
    - source: salt://php/conf/www.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php{{ v }}-fpm
