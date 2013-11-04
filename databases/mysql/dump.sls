
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

/etc/cron.daily/dump_mysql:
    file.managed:
        - source: salt://oopss-infra/databases/mysql/dump_mysql
        - user: root
        - group: root
        - mode: 700

