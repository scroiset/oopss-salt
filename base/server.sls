
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.base

oopss_base_server_pkg:
    pkg:
        - installed
        - names:
            - bonnie++
            - cron-apt
            - debian-goodies
            - gdisk
            - htop
            - iotop
            - ntp
            - rsyslog
            - sudo

