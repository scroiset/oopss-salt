
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

{% set user_create = salt['pillar.get']('oopss:nagios:user_create', False) %}
{% set user_name = salt['pillar.get']('oopss:nagios:user_name', 'nagios') %}
{% set user_group = salt['pillar.get']('oopss:nagios:user_group', False) %}
{% set user_home = salt['pillar.get']('oopss:nagios:user_home', '/var/lib/nagios') %}
{% set user_key = salt['pillar.get']('oopss:nagios:user_key', False) %}

oopss_nagios_pkg:
    pkg:
        - name: nagios-plugins
        - installed

{% if user_create %}
oopss_nagios_user:
    user:
        - name: {{ user_name }}
        - present
        - system: True
        - home: {{ user_home }}
        {% if user_group %}
        - groups:
            - {{ user_group }}
        {% endif %}

oopss_nagios_userhomedir:
    file.directory:
        - name: {{ user_home }}
        - mode: 700
        - user: {{ user_name }}
        - group: {{ user_name }}
        - makedirs: True
        - require:
            - user: oopss_nagios_user

{% if user_key %}
oopss_nagios_userkey:
    ssh_auth:
        - name: {{ user_key }}
        - present
        - user: {{ user_name }}
        - require:
            - file: oopss_nagios_userhomedir
{% endif %}
{% endif %}

