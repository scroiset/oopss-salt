
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

apt-listchanges:
    pkg.installed

/etc/apt/listchanges.conf:
    file.managed:
        - source: salt://oopss-infra/sysutils/apt-listchanges/listchanges.conf
        - user: root
        - group: adm
        - mode: 440

