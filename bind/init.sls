
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

oopss_bind_pkg:
    pkg:
        - installed
        - name: bind9

oopss_bind_service:
    service:
        - running
        - name: bind9
        - reload: True
        - require:
            - pkg: oopss_bind_pkg

oopss_bind_logdir:
    file:
        - directory
        - name: /var/log/bind
        - user: bind
        - group: adm
        - perms: 750
        - require:
            - pkg: oopss_bind_pkg

oopss_bind_options:
    file:
        - managed
        - name: /etc/bind/named.conf.options
        - source: salt://oopss/bind/files/named.conf.options
        - template: jinja
        - user: root
        - group: adm
        - perms: 440
        - require:
            - pkg: oopss_bind_pkg
            - file: oopss_bind_logdir
        - watch_in:
            - service: oopss_bind_service

