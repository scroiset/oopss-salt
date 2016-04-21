
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

nginx:
    pkg:
        - installed

    service:
        - running
        - reload: True
        - require:
            - pkg: nginx
        - watch:
            - file: /etc/nginx/conf.d/local.conf
            - file: /etc/nginx/common.conf
            - file: /etc/nginx/sites-available/default
{% for user, userinfo in salt['pillar.get']('http:users', {}).iteritems() %}
            - group: {{ user }}
{% endfor %}


/etc/nginx/conf.d/local.conf:
    file.managed:
        - source: salt://oopss/http/nginx/local.conf
        - template: jinja
        - user: root
        - group: root
        - mode: 400

/etc/nginx/common.conf:
    file.managed:
        - source: salt://oopss/http/nginx/common.conf
        - user: root
        - group: root
        - mode: 400

/etc/nginx/sites-available/default:
    file.managed:
        - source: salt://oopss/http/nginx/default_server
        - template: jinja
        - context:
            ssl: {{ salt['pillar.get']('http:nginx:ssl', {}) }}
            phpmyadmin_ssl_server: {{ salt['pillar.get']('http:nginx:phpmyadmin_ssl_server', False) }}
        - user: root
        - group: root
        - mode: 400

apache2-utils:
    pkg.installed

