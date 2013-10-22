
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

# Define timezone
{% if pillar['timezone'] is defined %}
/etc/localtime:
    file.symlink:
        - target: /usr/share/zoneinfo/{{ pillar['timezone'] }}
        - force: True
{% endif %}

