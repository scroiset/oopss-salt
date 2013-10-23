
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
            server_name: {% for server_name in root_pathinfo['server_names'] %} {{ server_name }}{% endfor %}
            root: /srv/www/{{ user }}/{{ root_path }}
            access_log: /srv/www/{{ user }}/log/{{ root_path }}-access.log
            error_log: /srv/www/{{ user }}/log/{{ root_path }}-error.log
{% for tag in root_pathinfo['config_tags'] %}
            tag_{{ tag }}: True
{% endfor %}
            socket: /srv/www/{{ user }}/.sock/{{ root_path }}.sock
        - require:
            - pkg: nginx

/etc/nginx/sites-enabled/{{ user }}-{{ root_path }}:
    file.symlink:
        - target: /etc/nginx/sites-available/{{ user }}-{{ root_path }}
        - force: True
        - require:
            - file: /etc/nginx/sites-available/{{ user }}-{{ root_path }}

{% endfor %}
{% endfor %}
{% endif %}

