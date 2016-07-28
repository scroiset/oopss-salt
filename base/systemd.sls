
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

# Enable systemd-journal
{% if grains['os'] == 'Debian' and grains['osrelease_info'][0] >= 8 %}
oopss_base_systemd_journaldir:
    file:
        - directory
        - name: /var/log/journal
        - user: root
        - group: root
        - mode: 700

oopss_base_systemd_journalreload:
    cmd:
        - run
        - name: "systemctl restart systemd-journald"
        - onchanges:
            - file: oopss_base_systemd_journaldir
{% endif %}

