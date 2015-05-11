
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

bind9:
    pkg:
        - installed
    service:
        - running
        - reload: True
        - watch:
            - file: /etc/bind/named.conf.local
            - file: /etc/bind/named.conf.options

/var/log/bind:
    file.directory:
        - user: bind
        - group: adm
        - perms: 750

/etc/bind/named.conf.options:
    file.managed:
        - source: salt://oopss-infra/dns/bind/named.conf.options
        - template: jinja
        - user: root
        - group: adm
        - perms: 440
        - require:
            - pkg: bind9
            - file: /var/log/bind

