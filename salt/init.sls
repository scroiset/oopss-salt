
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

salt-minion:
    pkg.installed

oopss_salt_minion_config:
    file.managed:
        - name: /etc/salt/minion.d/local.conf
        - source: salt://oopss/salt/files/minion
        - template: jinja
        - context:
            salt_master: {{ salt['pillar.get']('oopss:sysutils:salt:salt_master', 'salt') }}
        - user: root
        - group: root
        - mode: 400

