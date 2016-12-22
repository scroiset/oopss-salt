
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.nginx

oopss_nagios_nginx_pkg:
    pkg:
        - installed
        - names:
            - php5-fpm
            - spawn-fcgi
            - fcgiwrap

oopss_nagios_nginx_conf:
    file:
        - managed
        - name: /etc/nginx/sites-available/nagios
        - source: salt://oopss/nagios/files/nginx_vhost
        - template: jinja
        - user: root
        - group: adm
        - mode: 440
        - context:
            nagios_hostname: {{ salt['pillar.get']('oopss:nagios:nginx:hostname', 'nagios.localdomain') }}
        - require:
            - pkg: oopss_nginx_pkg
            - pkg: oopss_nagios_nginx_pkg
        - watch_in:
            - service: oopss_nginx_service

oopss_nagios_nginx_conf_enable:
    file:
        - symlink
        - name: /etc/nginx/sites-enabled/nagios
        - target: /etc/nginx/sites-available/nagios
        - force: True
        - require:
            - file: oopss_nagios_nginx_conf
        - watch_in:
            - service: oopss_nginx_service

