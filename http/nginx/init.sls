
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

##############################################################################
# Install packages
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
            - user: www-data

/etc/nginx/conf.d/local.conf:
    file.managed:
        - source: salt://oopss-infra/http/nginx/local.conf
        - template: jinja
        - user: root
        - group: root
        - mode: 400

/etc/nginx/common.conf:
    file.managed:
        - source: salt://oopss-infra/http/nginx/common.conf
        - user: root
        - group: root
        - mode: 400

/etc/nginx/sites-available/default:
    file.managed:
        - source: salt://oopss-infra/http/nginx/default_server
        - template: jinja
        - context:
            ssl_cert: {{ salt['pillar.get']('http:nginx:default_server:ssl_cert', '') }}
            phpmyadmin: {{ salt['pillar.get']('http:nginx:default_server:phpmyadmin', '') }}
        - user: root
        - group: root
        - mode: 400

apache2-utils:
    pkg.installed

##############################################################################
# Read http:users pillar and create virtual hosts
##############################################################################

{% if salt['pillar.get']('http:users') is defined %}
{% for user, userinfo in salt['pillar.get']('http:users').iteritems() %}
{% if userinfo['root_paths'] is defined %}
{% for root_path, root_pathinfo in userinfo['root_paths'].iteritems() %}

/etc/nginx/sites-available/{{ user }}-{{ root_path }}:
    file.managed:
        - user: root
        - group: adm
        - mode: 440
        - source: salt://oopss-infra/http/nginx/vhost
        - template: jinja
        - context:
            user: {{ user }}
            root_path: {{ root_path }}
            root_pathinfo: {{ root_pathinfo }}
            socket: {{ salt['pillar.get']('http:basedir') }}/{{ user }}/.sock/{{ root_path }}.sock
        - require:
            - pkg: nginx
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}/{{ root_path }}
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}/log/{{ root_path }}-access.log
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}/log/{{ root_path }}-error.log
        - watch_in:
            - service: nginx

/etc/nginx/sites-enabled/{{ user }}-{{ root_path }}:
    file.symlink:
        - target: /etc/nginx/sites-available/{{ user }}-{{ root_path }}
        - force: True
        - require:
            - file: /etc/nginx/sites-available/{{ user }}-{{ root_path }}
        - watch_in:
            - service: nginx

{% endfor %}
{% endif %}
{% endfor %}
{% endif %}

