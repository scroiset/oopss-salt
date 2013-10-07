
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

bind9:
    pkg:
        - installed
    service:
        - running
        - watch:
            - file: /etc/bind/named.conf.local
            - file: /etc/bind/named.conf.options

