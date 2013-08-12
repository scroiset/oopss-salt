
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

base:
    '*':
        - mail.postfix
        - net.ssh.server
        - scm.git
        - sysutils.cron-apt
        - sysutils.rsyslog
        - sysutils.users
        - utils.screen
        - utils.vim

