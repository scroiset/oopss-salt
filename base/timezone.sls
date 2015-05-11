
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

# Define timezone
{% if salt['pillar.get']('oopss:base:timezone', False) %}
oopss_base_timezone_file:
    file:
        - name: /etc/localtime
        - symlink
        - target: /usr/share/zoneinfo/{{ pillar['oopss']['base']['timezone'] }}
        - force: True
{% endif %}

