
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.bind

oopss_bind_masterconfdir:
    file:
        - directory
        - name: /etc/bind/master
        - user: bind
        - group: adm
        - perms: 750
        - require:
            - pkg: oopss_bind_pkg

oopss_bind_localconf:
    file:
        - managed
        - name: /etc/bind/named.conf.local
        - source: salt://oopss/bind/files/named.conf.master
        - template: jinja
        - user: root
        - group: adm
        - perms: 440
        - require:
            - pkg: oopss_bind_pkg
        - watch_in:
            - service: oopss_bind_service

