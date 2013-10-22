
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

debconf-utils:
    pkg.installed

sysstat-debconf:
    debconf.set:
        - name: sysstat
        - data:
            'sysstat/enable': {'type': 'boolean', 'value': 'true'}
        - require:
            - pkg: debconf-utils

sysstat:
    pkg:
        - installed
        - require:
            - debconf: sysstat-debconf

