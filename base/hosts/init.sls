
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

/etc/hosts:
    file.managed:
        - source: salt://base/hosts/hosts
        - mode: 444
        - owner: root
        - group: root
        - backup: minion

