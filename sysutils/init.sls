
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
    - oopss-infra.sysutils.apt-listchanges

pkg_sysutils:
    pkg:
        - installed
        - names:
            - bonnie++
            - cron-apt
            - debian-goodies
            - gdisk
            - htop
            - iotop
            - rsyslog
            - sudo

