
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_users_sshgroup:
    group:
        - name: sshusers
        - present
        - system: True

{% for user, userinfo in salt['pillar.get']('oopss:base:users', {}).iteritems() %}

{% set homedir = userinfo['home'] | default(['/home', user]|join('/')) %}

oopss_base_users_group_{{ user }}:
    group.present:
        - name: {{ user }}
        - gid: {{ userinfo['uid'] }}

oopss_base_users_user_{{ user }}:
    user.present:
        - name: {{ user }}
        - uid: {{ userinfo['uid'] }}
        - gid: {{ userinfo['uid'] }}
        - home: {{ homedir }}
        - createhome: False
        - shell: "/bin/bash"
        - fullname: {{ userinfo['fullname'] }}
        {% if userinfo['password'] is defined and userinfo['password'] %}
        - password: {{ userinfo['password'] }}
        {% else %}
        - password: '!'
        {% endif %}
        - groups:
        {% if userinfo.get('ssh', False) %}
            - sshusers
        {% endif %}
        {% if userinfo.get('sudoer', False) %}
            - sudo
        {% endif %}
        {% if userinfo.get('adm', False) %}
            - adm
        {% endif %}
        - require:
            - group: oopss_base_users_group_{{ user }}
            - group: sshusers

oopss_base_users_homedir_{{ user }}:
    file.directory:
        - name: {{ homedir }}
        - mode: 700
        - user: {{ user }}
        - group: {{ user }}
        - makedirs: True
        - require:
            - user: oopss_base_users_user_{{ user }}

{% if userinfo['ssh_auth'] is defined %}
oopss_base_users_ssh_keys_{{ user }}:
    file:
        - managed
        - name: {{ homedir }}/.ssh/authorized_keys
        - contents: {{ userinfo['ssh_auth'] }}
        - makedirs: True
        - user: {{ user }}
        - group: {{ user }}
        - mode: 400
        - require:
            - file: oopss_base_users_homedir_{{ user }}
{% endif %}
{% endfor %}

