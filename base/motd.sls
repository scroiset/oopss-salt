
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

{% if salt['pillar.get']('oopss:base:motd_file', False) %}
oopss_base_motd_file:
    file:
        - name: /etc/motd
        - managed
        - source: {{ salt['pillar.get']('oopss:base:motd_file') }}
        - user: root
        - group: root
        - mode: 444
{% endif %}

