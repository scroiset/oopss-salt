
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

{% if salt['pillar.get']('oopss:base:hosts', False) %}
oopss_base_hosts:
    file:
        - name: /etc/hosts
        - managed
        - source: {{ salt['pillar.get']('oopss:base:hosts') }}
        - user: root
        - group: root
        - mode: 644
{% endif %}

