
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_munin_pkg:
    pkg:
        - installed
        - name: munin-node

oopss_munin_service:
    service:
        - running
        - name: munin-node
        - enable: True

oopss_munin_conf:
    file:
        - managed
        - name: /etc/munin/munin-node.conf
        - source: salt://oopss/munin/files/munin-node.conf
        - template: jinja
        - user: root
        - group: root
        - mode: 400
        - watch_in:
            service: oopss_munin_service
        - require:
            - pkg: oopss_munin_pkg

{% if salt['pillar.get']('oopss:munin:http_server', False) == 'oopss.nginx' %}
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
            munin_hostname: {{ salt['pillar.get']('oopss:munin:http_hostname', 'munin.localdomain') }}
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
{% endif %}

