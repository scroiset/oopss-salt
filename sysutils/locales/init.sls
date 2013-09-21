
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

locales:
    pkg.installed

/etc/locale.gen:
    file:
        - managed
        - source: salt://sysutils/locales/locale.gen
        - mode: 644
        - user: root
        - group: root
        - backup: minion
        - require:
            - pkg: locales

# Run locale-gen(8) if /etc/locale.gen changes
locale-gen:
    cmd.wait:
        - watch:
            - file: /etc/locale.gen

