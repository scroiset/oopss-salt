
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.dns.bind

extend:
    bind9:
        service:
            - watch:
                - file: /etc/bind/named.conf.local
                - file: /etc/bind/named.conf.options

/var/log/bind:
    file.directory:
        - user: bind
        - group: adm
        - perms: 750

/etc/bind/named.conf.local:
    file.managed:
        - source: salt://oopss-infra/dns/bind/named.conf.local
        - template: jinja
        - user: root
        - group: adm
        - perms: 440
        - require:
            - pkg: bind9

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

/etc/bind/slave:
    file.directory:
        - user: bind
        - group: adm
        - perms: 750
 
