
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

# Starting with Debian Jessie, the check_drbd is provided by the
# nagios-plugins-contrib package. Before, it has to be installed manually.
{% if grains['os'] == 'Debian' and grains['osrelease_info'][0] < 8 %}
oopss_drbd_nagios_pluginfile:
    file:
        - managed
        - name: /usr/lib/nagios/plugins/check_drbd
        - source: salt://oopss/drbd/files/check_drbd
        - user: root
        - group: root
        - mode: 755
{% else %}
oopss_drbd_nagios_pkg:
    pkg:
        - installed
        - name: nagios-plugins-contrib
{% endif %}

