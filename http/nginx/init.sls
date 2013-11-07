
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

/etc/nginx/conf.d/local.conf:
    file.managed:
        - source: salt://oopss-infra/http/nginx/local.conf
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
{% for root_path, root_pathinfo in userinfo['root_paths'].iteritems() %}

/etc/nginx/sites-available/{{ user }}-{{ root_path }}:
    file.managed:
        - user: root
        - group: adm
        - mode: 440
        - source: salt://oopss-infra/http/nginx/vhost
        - template: jinja
        - context:
            server_names: {{ root_pathinfo['server_names'] }}
            root: /srv/www/{{ user }}/{{ root_path }}
            access_log: /srv/www/{{ user }}/log/{{ root_path }}-access.log
            error_log: /srv/www/{{ user }}/log/{{ root_path }}-error.log
{% for tag in root_pathinfo['config_tags'] %}
            tag_{{ tag }}: True
{% endfor %}
            socket: /srv/www/{{ user }}/.sock/{{ root_path }}.sock
            user: {{ user }}
            root_path: {{ root_path }}
        - require:
            - pkg: nginx
            - file: /srv/www/{{ user }}/{{ root_path }}
            - file: /srv/www/{{ user }}/log/{{ root_path }}-access.log
            - file: /srv/www/{{ user }}/log/{{ root_path }}-error.log
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
{% endfor %}
{% endif %}

