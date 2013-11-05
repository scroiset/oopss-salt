
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

salt-minion:
    pkg.installed

/etc/salt/minion:
    file.managed:
        - source: salt://oopss-infra/sysutils/salt/minion
        - template: jinja
        - context:
            salt_master: {{ salt['pillar.get']('sysutils:salt:salt_master', 'salt') }}
        - user: root
        - group: root
        - mode: 400

