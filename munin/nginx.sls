
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.nginx

oopss_munin_nginx_conf:
    file:
        - managed
        - name: /etc/nginx/sites-available/munin
        - source: salt://oopss/munin/files/nginx_vhost
        - template: jinja
        - user: root
        - group: adm
        - mode: 440
        - context:
            munin_hostname: {{ salt['pillar.get']('oopss:munin:nginx:hostname', 'munin.localdomain') }}
        - require:
            - pkg: oopss_nginx_pkg
        - watch_in:
            - service: oopss_nginx_service

oopss_munin_nginx_conf_enable:
    file:
        - symlink
        - name: /etc/nginx/sites-enabled/munin
        - target: /etc/nginx/sites-available/munin
        - force: True
        - require:
            - file: oopss_munin_nginx_conf
        - watch_in:
            - service: oopss_nginx_service

