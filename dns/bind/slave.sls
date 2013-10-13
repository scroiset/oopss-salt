
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

include:
    - dns.bind

/var/log/bind:
    file.directory:
        - user: bind
        - group: bind
        - perms: 755

/etc/bind/named.conf.local:
    file.managed:
        - source: salt://oopss-infra/dns/bind/named.conf.local
        - template: jinja
        - user: root
        - group: root
        - perms: 444
        - require:
            - pkg: bind9

/etc/bind/named.conf.options:
    file.managed:
        - source: salt://oopss-infra/dns/bind/named.conf.options
        - template: jinja
        - user: root
        - group: root
        - perms: 444
        - require:
            - pkg: bind9
            - file: /var/log/bind

/etc/bind/slave:
    file.directory:
        - user: bind
        - group: bind
        - perms: 755
 