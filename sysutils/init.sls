
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.dns.unbound
    - oopss-infra.mail.postfix
    - oopss-infra.net.ssh.server
    - oopss-infra.sysutils.nagios
    - oopss-infra.sysutils.salt

pkg_sysutils:
    pkg:
        - installed
        - names:
            - apt-listchanges
            - bonnie++
            - cron-apt
            - gdisk
            - htop
            - iotop
            - rsyslog
            - sudo

