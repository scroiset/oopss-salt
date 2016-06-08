
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

oopss_nginx_pkg:
    pkg:
        - installed
        - names:
            - nginx
            - apache2-utils

oopss_nginx_service:
    service:
        - running
        - name: nginx
        - reload: True
        - require:
            - pkg: oopss_nginx_pkg
        - watch:
            - file: /etc/nginx/conf.d/local.conf
            - file: /etc/nginx/sites-available/default


/etc/nginx/conf.d/local.conf:
    file.managed:
        - source: salt://oopss/nginx/files/local.conf
        - template: jinja
        - user: root
        - group: root
        - mode: 400

/etc/nginx/sites-available/default:
    file.managed:
        - source: salt://oopss/nginx/files/default_server
        - template: jinja
        - context:
            ssl: {{ salt['pillar.get']('oopss:nginx:ssl', {}) }}
            phpmyadmin_ssl_server: {{ salt['pillar.get']('oopss:nginx:phpmyadmin_ssl_server', False) }}
        - user: root
        - group: root
        - mode: 400

