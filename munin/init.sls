
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_munin_pkg:
    pkg:
        - installed
        - name: munin-node

oopss_munin_service:
    service:
        - running
        - name: munin-node
        - enable: True

oopss_munin_conf:
    file:
        - managed
        - name: /etc/munin/munin-node.conf
        - source: salt://oopss/munin/files/munin-node.conf
        - template: jinja
        - user: root
        - group: root
        - mode: 400
        - watch_in:
            service: oopss_munin_service
        - require:
            - pkg: oopss_munin_pkg

