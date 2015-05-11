
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

salt-minion:
    pkg.installed

/etc/salt/minion:
    file.managed:
        - source: salt://oopss/sysutils/salt/minion
        - template: jinja
        - context:
            salt_master: {{ salt['pillar.get']('oopss:sysutils:salt:salt_master', 'salt') }}
        - user: root
        - group: root
        - mode: 400

