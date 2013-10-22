
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

/etc/motd:
    file.managed:
        - user: root
        - group: root
        - mode: 444
        - source: salt://motd

