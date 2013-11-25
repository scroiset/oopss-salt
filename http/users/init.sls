
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

# Base directory for websites
{{ salt['pillar.get']('http:basedir') }}:
    file.directory:
        - user: root
        - group: root
        - mode: 711

# For each user in pillar http:users
{% if salt['pillar.get']('http:users') is defined %}
{% for user, userinfo in salt['pillar.get']('http:users').iteritems() %}

# Web user and group
{{ user }}:
    group.present:
        - gid: {{ userinfo['uid'] }}

    user.present:
        - uid: {{ userinfo['uid'] }}
        - gid: {{ userinfo['uid'] }}
        - password: '{{ userinfo['password'] }}'
        - home: "{{ salt['pillar.get']('http:basedir') }}/{{ user }}"
        - createhome: False
        - shell: "/bin/bash"
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
{{ salt['pillar.get']('http:basedir') }}/{{ user }}:
    file.directory:
        - mode: 750
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - user: {{ user }}

{% if userinfo['root_paths'] is defined %}

# Socket directory
{{ salt['pillar.get']('http:basedir') }}/{{ user }}/.sock:
    file.directory:
        - mode: 710
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}

# Log directory
{{ salt['pillar.get']('http:basedir') }}/{{ user }}/log:
    file.directory:
        - mode: 750
        - user: root
        - group: {{ user }}
        - require:
            - user: {{ user }}
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}

# For each root_path
{% for root_path in userinfo['root_paths'] %}

# Root path
{{ salt['pillar.get']('http:basedir') }}/{{ user }}/{{ root_path }}:
    file.directory:
        - user: {{ user }}
        - group: {{ user }}
        - mode: 750
        - require:
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}

# Web server access file
{{ salt['pillar.get']('http:basedir') }}/{{ user }}/log/{{ root_path }}-access.log:
    file.managed:
        - mode: 640
        - user: www-data
        - group: {{ user }}
        - require:
            - user: {{ user }}
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}/log

# Web server error file
{{ salt['pillar.get']('http:basedir') }}/{{ user }}/log/{{ root_path }}-error.log:
    file.managed:
        - mode: 640
        - user: www-data
        - group: {{ user }}
        - require:
            - user: {{ user }}
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}/log

# Logrotate config
/etc/logrotate.d/www-{{ user }}-{{ root_path }}:
    file.managed:
        - mode: 400
        - user: root
        - group: root
        - source: salt://oopss-infra/http/users/logrotate
        - template: jinja
        - context:
            user: {{ user }}
            root_path: {{ root_path }}
        - require:
            - user: {{ user }}

{% endfor %}
{% endif %}
{% endfor %}
{% endif %}

# Add www-data system user in each user group, so it can access static files
www-data:
    user.present:
        - groups:
            - www-data
{% if salt['pillar.get']('http:users') is defined %}
{% for user, userinfo in salt['pillar.get']('http:users').iteritems() %}
{% if userinfo['root_paths'] is defined %}
            - {{ user }}
{% endif %}
{% endfor %}
        - require:
{% for user, userinfo in salt['pillar.get']('http:users').iteritems() %}
{% if userinfo['root_paths'] is defined %}
            - group: {{ user }}
{% endif %}
{% endfor %}
{% endif %}

