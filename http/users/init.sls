
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

{% from "oopss/http/map.jinja" import http_config with context %}

{% if salt['pillar.get']('http:web_server', False) == 'oopss.nginx' %}
include:
    - oopss.nginx
{% endif %}

{{ http_config['rootdir'] }}:
    file.directory:
        - user: root
        - group: root
        - mode: 711

# For each user in pillar http:users
{% for user, userinfo in salt['pillar.get']('http:users', {}).iteritems() %}

# Web user and group
{{ user }}:
    group.present:
        - gid: {{ userinfo['uid'] }}
        - addusers:
            - www-data
{% if salt['pillar.get']('http:web_server', False) == 'oopss.nginx' %}
        - watch_in:
            - service: oopss_nginx_service
{% endif %}

    user.present:
        - uid: {{ userinfo['uid'] }}
        - gid: {{ userinfo['uid'] }}
        - password: '{{ userinfo['password'] }}'
        - home: "{{ http_config['rootdir'] }}/{{ user }}"
        - shell: "/bin/bash"
        - createhome: False
        - fullname: ""
        - groups:
            - sshusers
{% if userinfo['additional_groups'] is defined %}
{% for group in userinfo['additional_groups'] %}
            - {{ group }}
{% endfor %}
{% endif %}
        - require:
            - group: {{ user }}
{% if userinfo['additional_groups'] is defined %}
{% for group in userinfo['additional_groups'] %}
            - group: {{ group }}
{% endfor %}
{% endif %}

# Web user home directory
{{ http_config['rootdir'] }}/{{ user }}:
    file.directory:
        - mode: 750
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - user: {{ user }}

{% if userinfo['root_paths'] is defined %}

# Socket directory
{{ http_config['rootdir'] }}/{{ user }}/.sock:
    file.directory:
        - mode: 710
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - file: {{ http_config['rootdir'] }}/{{ user }}

# SSH directory
{{ http_config['rootdir'] }}/{{ user }}/.ssh:
    file.directory:
        - mode: 700
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - file: {{ http_config['rootdir'] }}/{{ user }}

# SSH authorized_keys
{{ http_config['rootdir'] }}/{{ user }}/.ssh/authorized_keys:
    file.managed:
        - mode: 600
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - file: {{ http_config['rootdir'] }}/{{ user }}/.ssh

# Log directory
{{ http_config['rootdir'] }}/{{ user }}/log:
    file.directory:
        - mode: 750
        - user: root
        - group: {{ user }}
        - require:
            - user: {{ user }}
            - file: {{ http_config['rootdir'] }}/{{ user }}

# For each root_path
{% for root_path, root_pathinfo in userinfo.get('root_paths', {}).iteritems() %}

# Root path
{{ http_config['rootdir'] }}/{{ user }}/{{ root_path }}:
    file.directory:
        - user: {{ user }}
        - group: {{ user }}
        - mode: 750
        - require:
            - file: {{ http_config['rootdir'] }}/{{ user }}

# Web server access file
{{ http_config['rootdir'] }}/{{ user }}/log/{{ root_path }}-access.log:
    file.managed:
        - mode: 640
        - user: www-data
        - group: {{ user }}
        - require:
            - user: {{ user }}
            - file: {{ http_config['rootdir'] }}/{{ user }}/log

# Web server error file
{{ http_config['rootdir'] }}/{{ user }}/log/{{ root_path }}-error.log:
    file.managed:
        - mode: 640
        - user: www-data
        - group: {{ user }}
        - require:
            - user: {{ user }}
            - file: {{ http_config['rootdir'] }}/{{ user }}/log

# Logrotate config
/etc/logrotate.d/www-{{ user }}-{{ root_path }}:
    file.managed:
        - mode: 400
        - user: root
        - group: root
        - source: salt://oopss/http/users/logrotate
        - template: jinja
        - context:
            user: {{ user }}
            root_path: {{ root_path }}
        - require:
            - user: {{ user }}

# If using Nginx
{% if salt['pillar.get']('http:web_server', False) == 'oopss.nginx' %}
/etc/nginx/sites-available/{{ user }}-{{ root_path }}:
    file.managed:
        - user: root
        - group: adm
        - mode: 440
        - source: salt://oopss/http/users/files/vhost
        - template: jinja
        - context:
            user: {{ user }}
            root_path: {{ root_path }}
            root_pathinfo: {{ root_pathinfo }}
            socket: {{ http_config['rootdir'] }}/{{ user }}/.sock/{{ root_path }}.sock
        - require:
            - pkg: oopss_nginx_pkg
            - file: {{ http_config['rootdir'] }}/{{ user }}/{{ root_path }}
            - file: {{ http_config['rootdir'] }}/{{ user }}/log/{{ root_path }}-access.log
            - file: {{ http_config['rootdir'] }}/{{ user }}/log/{{ root_path }}-error.log
        - watch_in:
            - service: oopss_nginx_service

/etc/nginx/sites-enabled/{{ user }}-{{ root_path }}:
    file.symlink:
        - target: /etc/nginx/sites-available/{{ user }}-{{ root_path }}
        - force: True
        - require:
            - file: /etc/nginx/sites-available/{{ user }}-{{ root_path }}
        - watch_in:
            - service: oopss_nginx_service
{% endif %}

{% endfor %}
{% endif %}
{% endfor %}

