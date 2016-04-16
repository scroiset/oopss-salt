
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

oopss_drbd_pkg:
    pkg:
        - name: drbd8-utils
        - installed

oopss_drbd_config:
    file:
        - managed
        - name: /etc/drbd.d/global_common.conf
        - source: salt://oopss/drbd/files/global_common.conf
        - user: root
        - group: adm
        - mode: 640
        - require:
            - pkg: oopss_drbd_pkg

{% if salt['pillar.get']('oopss:drbd:local_config_location', False) %}
oopss_drbd_config_local:
    file:
        - recurse
        - name: /etc/drbd.d/
        - source: {{ salt['pillar.get']('oopss:drbd:local_config_location') }}
        - file_mode: 400
{% endif %}
