
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

# Starting with Debian Jessie, rsyslog is not needed anymore
{% if grains['os'] == 'Debian' and grains['osrelease_info'][0] < 8 %}

# Disable kernel logging on LXC guests
{% if grains['virtual_subtype'] is defined and grains['virtual_subtype'] == 'LXC' %}
oopss_base_rsyslog_disable_ikmlog:
    file:
        - comment
        - name: /etc/rsyslog.conf
        - regex: '^\$ModLoad imklog'
        - watch_in:
            - service: oopss_base_rsyslog_service
{% endif %}

oopss_base_rsyslog_service:
    service:
        - running
        - name: rsyslog

{% endif %}
