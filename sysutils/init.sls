
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.dns.unbound
    - oopss-infra.mail.postfix
    - oopss-infra.net.ssh.server
    - oopss-infra.sysutils.cron-apt
    - oopss-infra.sysutils.nagios
    - oopss-infra.sysutils.perf-tools
    - oopss-infra.sysutils.rsyslog
    - oopss-infra.sysutils.salt
    - oopss-infra.sysutils.sudo
    - oopss-infra.sysutils.sysstat

