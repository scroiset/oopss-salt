
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

{% for config_file, location in salt['pillar.get']('oopss:drbd:config_files', []).iteritems() %}
oopss_drbd_config_{{ config_file }}:
    file:
        - managed
        - name: /etc/drbd.d/{{ config_file }}
        - source: {{ location }}
        - user: root
        - group: adm
        - mode: 640
        - require:
            - pkg: oopss_drbd_pkg
{% endfor %}

