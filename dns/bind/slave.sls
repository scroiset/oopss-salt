
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.dns.bind

/etc/bind/slave:
    file.directory:
        - user: bind
        - group: adm
        - perms: 750

/etc/bind/named.conf.local:
    file.managed:
        - source: salt://oopss-infra/dns/bind/named.conf.slave
        - template: jinja
        - user: root
        - group: adm
        - perms: 440
        - require:
            - pkg: bind9

