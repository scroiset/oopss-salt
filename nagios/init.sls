
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_nagios_pkg:
    pkg:
        - name: nagios-plugins
        - installed

{% if salt['pillar.get']('oopss:nagios:user_create', False) %}
oopss_nagios_user:
    user:
        - name: {{ salt['pillar.get']('oopss:nagios:user_name', 'nagios') }}
        - present
        - system: True
        - home: {{ salt['pillar.get']('oopss:nagios:user_home', '/var/lib/nagios') }}
        {% if salt['pillar.get']('oopss:nagios:user_group', False) %}
        - groups:
            - {{ salt['pillar.get']('oopss:nagios:user_group') }}
        {% endif %}

oopss_nagios_userhomedir:
    file.directory:
        - name: {{ salt['pillar.get']('oopss:nagios:user_home', '/var/lib/nagios') }}
        - mode: 700
        - user: {{ salt['pillar.get']('oopss:nagios:user_name', 'nagios') }}
        - group: {{ salt['pillar.get']('oopss:nagios:user_name', 'nagios') }}
        - makedirs: True
        - require:
            - user: oopss_nagios_user

{% if salt['pillar.get']('oopss:nagios:user_key', False) %}
oopss_nagios_userkey:
    ssh_auth:
        - name: {{  salt['pillar.get']('oopss:nagios:user_key') }}
        - present
        - user: {{ salt['pillar.get']('oopss:nagios:user_name', 'nagios') }}
        - require:
            - file: oopss_nagios_userhomedir
{% endif %}
{% endif %}

