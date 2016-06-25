
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_sysutils_pkg:
    pkg:
        - installed
        - names:
            - bonnie++
            - cron-apt
            - debian-goodies
            - fio
            - gdisk
            - htop
            - iotop
            - nmap
            - sudo
            - sysstat

